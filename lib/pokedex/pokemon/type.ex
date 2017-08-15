defmodule Pokedex.Pokemon.Type do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon.Type

  schema "types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Type{} = type, attrs) do
    type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
