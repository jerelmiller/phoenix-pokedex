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

defmodule Data.Created do
  defstruct types: [], pokemon: []
end

defmodule DataHelper do
  import Ecto.Query

  def create_from_file(file) do
    data = parse_pokemon(file)

    %Data.Created{}
    |> create_types(data)
    |> create_pokemon(data)
  end

  defp parse_pokemon(file) do
    file
    |> File.read!()
    |> Poison.decode!(as: [%Data.Pokemon{}], keys: :atoms)
  end

  defp create_pokemon(created, data) do
    Enum.map(data, &find_or_create_pokemon/1)
    |> put_pokemon(created)
  end

  defp create_types(created, data) do
    data
    |> Enum.flat_map(fn (pokemon) ->
      pokemon.types ++ pokemon.weaknesses ++ pokemon.strengths
    end)
    |> Enum.uniq
    |> Enum.map(types, &find_or_create_type/1)
    |> put_types(created)
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

  defp put_pokemon(pokemon, created), do: %{created | pokemon: pokemon}
  defp put_types(types, created), do: %{created | types: types}
end

DataHelper.create_from_file("priv/repo/pokemon.json")
