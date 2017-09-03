# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pokedex.Repo.insert!(%Pokedex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

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
    associate_types(pokemon, data, :types, Pokemon.PokemonType)
    associate_types(pokemon, data, :weaknesses, Pokemon.PokemonWeakness)
    associate_types(pokemon, data, :strengths, Pokemon.PokemonStrength)
  end

  defp associate_types(pokemon, data, association, schema) do
    Map.fetch!(data, association)
    |> Enum.with_index
    |> Enum.each(fn ({type, order}) ->
      type = find_or_create_type(type)

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

  def find_or_create(query, changeset) do
    Repo.one(query) || Repo.insert!(changeset)
  end
end

DataHelper.create_from_file("priv/repo/pokemon.json")
