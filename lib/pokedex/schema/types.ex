defmodule Pokedex.Schema.Types do
  use Absinthe.Schema.Notation

  object :pokemon do
    field :id, :id
    field :attack, :integer
    field :description, :string
    field :height, :float
    field :hp, :integer
    field :name, :string
    field :number, :string
    field :special_attack, :integer
    field :special_defense, :integer
    field :speed, :integer
    field :weight, :float

    field :types, list_of(:string),
      resolve: Pokedex.Lookup.assoc_lookup(:types, :name)
  end
end
