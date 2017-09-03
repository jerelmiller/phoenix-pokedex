alias Pokedex.{Pokemon, Repo}

defmodule Data.Pokemon do
  @derive [Poison.Encoder]

  defstruct [
    :attack, :defense, :description, :evolution, :evolution_chain, :height,
    :hp, :involution, :moves, :name, :number, :special_attack, :special_defense,
    :speed, :stamina, :strengths, :types, :weaknesses, :weight
  ]
end

defmodule DataHelper do
  import Ecto.Query

  def create_from_file(file) do
    parse_pokemon(file)
    |> Enum.each(&create_pokemon/1)
  end

  defp parse_pokemon(file) do
    file
    |> File.read!()
    |> Poison.decode!(as: [%Data.Pokemon{}], keys: :atoms)
  end

  defp create_pokemon(data) do
    data
    |> find_or_create_pokemon()
    |> associate_relationships(data)
  end

  defp associate_relationships(pokemon, data) do
    associate_types(pokemon, data.types, Pokemon.PokemonType)
    associate_types(pokemon, data.weaknesses, Pokemon.PokemonWeakness)
    associate_types(pokemon, data.strengths, Pokemon.PokemonStrength)
    associate_moves(pokemon, data.moves)
  end

  defp associate_types(pokemon, types, schema) do
    types
    |> Enum.map(&find_or_create_type/1)
    |> Enum.with_index
    |> Enum.each(fn ({type, order}) ->
      find_or_create(
        (from pt in schema,
          where: pt.pokemon_id == ^pokemon.id and pt.type_id == ^type.id),
        schema.changeset(struct(schema), %{
          order: order,
          pokemon_id: pokemon.id,
          type_id: type.id
        })
      )
    end)
  end

  defp associate_moves(pokemon, moves) do
    moves
    |> Enum.map(fn move -> {move, find_or_create_move(move)} end)
    |> Enum.map(fn {data, move} ->
      find_or_create_pokemon_move(pokemon, move, data)
    end)
  end

  defp find_or_create_pokemon_move(pokemon, move, data) do
    find_or_create(
      (from pm in Pokemon.PokemonMove,
       where: pm.pokemon_id == ^pokemon.id and pm.move_id == ^move.id),
      fn ->
        move_method = find_or_create_move_method(data.move_method)

        Pokemon.PokemonMove.changeset(%Pokemon.PokemonMove{}, %{
          level: data.level,
          move_id: move.id,
          pokemon_id: pokemon.id,
          move_method_id: move_method.id
        })
      end
    )
  end

  defp find_or_create_move_method(move_method) do
    find_or_create(
      (from mm in Pokemon.MoveMethod, where: mm.name == ^move_method.name),
      Pokemon.MoveMethod.changeset(%Pokemon.MoveMethod{}, %{
        name: move_method.name,
        description: move_method.description
      })
    )
  end

  def find_or_create_move(move) do
    find_or_create(
      (from m in Pokemon.Move, where: m.name == ^move.name),
      fn ->
        effect = find_or_create_effect(move.effect)
        type = find_or_create_type(move.type)

        Pokemon.Move.changeset(%Pokemon.Move{}, %{
          accuracy: move.accuracy,
          effect_chance: move.effect_chance,
          effect_id: effect.id,
          name: move.name,
          power: move.power,
          pp: move.pp,
          type_id: type.id
        })
      end
    )
  end

  defp find_or_create_effect(effect) do
    find_or_create(
      (from e in Pokemon.Effect, where: e.description == ^effect.description),
      Pokemon.Effect.changeset(%Pokemon.Effect{}, %{
        description: effect.description
      })
    )
  end

  defp find_or_create_move_method(%{name: name} = move_method) do
    find_or_create(
      (from mm in Pokemon.MoveMethod, where: mm.name == ^name),
      Pokemon.MoveMethod.changeset(%Pokemon.MoveMethod{}, %{
        name: name,
        description: move_method.description
      })
    )
  end

  defp find_or_create_type(name) do
    find_or_create(
      (from t in Pokemon.Type, where: t.name == ^name),
      Pokemon.Type.changeset(%Pokemon.Type{}, %{name: name})
    )
  end

  defp find_or_create_pokemon(%{name: name} = pokemon) do
    find_or_create(
      (from p in Pokemon, where: p.name == ^name),
      Pokemon.changeset(%Pokemon{}, %{
        attack: pokemon.attack,
        defense: pokemon.defense,
        description: pokemon.description,
        height: pokemon.height,
        hp: pokemon.hp,
        name: pokemon.name,
        number: pokemon.number,
        special_attack: pokemon.special_attack,
        special_defense: pokemon.special_defense,
        speed: pokemon.speed,
        weight: pokemon.weight
      })
    )
  end

  def find_or_create(query, func) when is_function(func) do
    Repo.one(query) || Repo.insert!(func.())
  end

  def find_or_create(query, changeset) do
    Repo.one(query) || Repo.insert!(changeset)
  end
end

DataHelper.create_from_file("priv/repo/pokemon.json")
