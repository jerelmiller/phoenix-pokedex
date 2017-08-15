defmodule Pokedex.Pokemon.PokemonWeakness do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.{PokemonWeakness, Type}

  schema "pokemons_weaknesses" do
    belongs_to :pokemon, Pokemon
    belongs_to :type, Type

    timestamps()
  end

  @doc false
  def changeset(%PokemonWeakness{} = pokemon_weakness, attrs) do
    pokemon_weakness
    |> cast(attrs, [:pokemon_id, :type_id])
    |> validate_required([:pokemon_id, :type_id])
  end
end
