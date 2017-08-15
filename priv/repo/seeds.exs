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
    data = parse_pokemon(file)

    data
    |> create_types
  end

  defp create_types(data) do
    data
    |> Enum.flat_map(fn (pokemon) ->
      pokemon.types ++ pokemon.weaknesses ++ pokemon.strengths
    end)
    |> Enum.uniq
    |> insert_types
  end

  defp parse_pokemon(file) do
    file
    |> File.read!()
    |> Poison.decode!(as: [%Data.Pokemon{}], keys: :atoms)
  end

  defp insert_types(types) do
    Enum.map(types, &find_or_create_type/1)
  end

  defp find_or_create_type(name) do
    Repo.one(from t in Pokemon.Type, where: t.name == ^name) ||
      %Pokemon.Type{}
      |> Pokemon.Type.changeset(%{name: name})
      |> Repo.insert()
  end
end

DataHelper.create_from_file("priv/repo/pokemon.json")
