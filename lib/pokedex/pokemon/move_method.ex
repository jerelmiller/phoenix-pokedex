defmodule Pokedex.Pokemon.MoveMethod do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon.MoveMethod

  schema "move_methods" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%MoveMethod{} = move_method, attrs) do
    move_method
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
