defmodule Pokedex.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.{PokemonType, PokemonWeakness, Type}

  schema "pokemons" do
    field :description, :string
    field :name, :string
    field :number, :string

    many_to_many :types, Type, join_through: PokemonType
    many_to_many :weaknesses, Type, join_through: PokemonWeakness

    timestamps()
  end

  @doc false
  def changeset(%Pokemon{} = pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :number, :description])
    |> validate_required([:name, :number])
    |> unique_constraint(:name)
    |> unique_constraint(:number)
  end
end
