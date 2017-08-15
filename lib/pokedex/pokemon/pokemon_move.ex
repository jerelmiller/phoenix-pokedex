defmodule Pokedex.Pokemon.PokemonMove do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.{PokemonMove, Move}

  schema "pokemons_moves" do
    field :level, :integer

    belongs_to :pokemon, Pokemon
    belongs_to :move, Move

    timestamps()
  end

  @doc false
  def changeset(%PokemonMove{} = pokemon_move, attrs) do
    pokemon_move
    |> cast(attrs, [:level, :pokemon_id, :move_id])
    |> validate_required([:level, :pokemon_id, :move_id])
  end
end
