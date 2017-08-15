defmodule Pokedex.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.{
    PokemonType,
    PokemonWeakness,
    PokemonStrength,
    Type
  }

  schema "pokemons" do
    field :attack, :integer
    field :defense, :integer
    field :description, :string
    field :hp, :integer
    field :name, :string
    field :number, :string
    field :special_attack, :integer
    field :special_defense, :integer
    field :speed, :integer

    many_to_many :types, Type, join_through: PokemonType
    many_to_many :weaknesses, Type, join_through: PokemonWeakness
    many_to_many :strengths, Type, join_through: PokemonStrength

    timestamps()
  end

  @doc false
  def changeset(%Pokemon{} = pokemon, attrs) do
    pokemon
    |> cast(attrs, [
      :attack, :defense, :description, :hp, :name, :number, :special_attack,
      :special_defense, :speed
    ])
    |> validate_required([
      :attack, :defense, :hp, :name, :number, :special_attack,
      :special_defense, :speed
    ])
    |> unique_constraint(:name)
    |> unique_constraint(:number)
  end
end
