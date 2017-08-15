defmodule Pokedex.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon

  schema "pokemons" do
    field :description, :string
    field :name, :string
    field :number, :string

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
