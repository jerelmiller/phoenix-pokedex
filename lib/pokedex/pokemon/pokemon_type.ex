defmodule Pokedex.Pokemon.PokemonType do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon.PokemonType

  schema "pokemons_types" do
    field :pokemon_id, :id
    field :type_id, :id

    timestamps()
  end

  @doc false
  def changeset(%PokemonType{} = pokemon_type, attrs) do
    pokemon_type
    |> cast(attrs, [])
    |> validate_required([])
  end
end
