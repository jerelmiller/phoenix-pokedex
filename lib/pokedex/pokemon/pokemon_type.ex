defmodule Pokedex.Pokemon.PokemonType do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.{PokemonType, Type}

  schema "pokemons_types" do
    field :order, :integer

    belongs_to :pokemon, Pokemon
    belongs_to :type, Type

    timestamps()
  end

  @doc false
  def changeset(%PokemonType{} = pokemon_type, attrs) do
    pokemon_type
    |> cast(attrs, [:order, :pokemon_id, :type_id])
    |> validate_required([:order, :pokemon_id, :type_id])
  end
end
