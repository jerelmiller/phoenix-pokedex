defmodule Pokedex.Pokemon.PokemonStrength do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.{PokemonStrength, Type}

  schema "pokemons_strengths" do
    belongs_to :pokemon, Pokemon
    belongs_to :type, Type

    timestamps()
  end

  @doc false
  def changeset(%PokemonStrength{} = pokemon_strength, attrs) do
    pokemon_strength
    |> cast(attrs, [:pokemon_id, :type_id])
    |> validate_required([:pokemon_id, :type_id])
  end
end
