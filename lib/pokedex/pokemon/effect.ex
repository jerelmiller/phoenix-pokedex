defmodule Pokedex.Pokemon.Effect do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon.Effect

  schema "effects" do
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Effect{} = effect, attrs) do
    effect
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
