defmodule Pokedex.Pokemon.Move do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pokedex.Pokemon.{Effect, Move, Type}

  schema "moves" do
    field :accuracy, :integer
    field :effect_chance, :integer
    field :name, :string
    field :power, :integer
    field :pp, :integer

    belongs_to :type, Type
    belongs_to :effect, Effect

    timestamps()
  end

  @doc false
  def changeset(%Move{} = move, attrs) do
    move
    |> cast(attrs, [
      :name, :power, :pp, :accuracy, :effect_chance, :type_id, :effect_id
    ])
    |> validate_required([
      :name, :power, :pp, :accuracy, :type_id, :effect_id
    ])
  end
end
