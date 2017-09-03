defmodule Pokedex.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Pokedex.Repo

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

    field :weaknesses, list_of(:string),
      resolve: Pokedex.Lookup.assoc_lookup(:weaknesses, :name)

    field :strengths, list_of(:string),
      resolve: Pokedex.Lookup.assoc_lookup(:strengths, :name)

    field :pokemon_moves, list_of(:pokemon_move),
      resolve: assoc(:pokemon_moves)
  end

  object :pokemon_move do
    field :level, non_null(:integer)

    field :move, :move, resolve: assoc(:move)
    field :move_method, :move_method, resolve: assoc(:move_method)
  end

  object :move do
    field :accuracy, :integer
    field :effect_chance, :integer
    field :name, non_null(:string)
    field :power, :integer
    field :pp, non_null(:integer)

    field :effect, non_null(:string),
      resolve: Pokedex.Lookup.assoc_lookup(:effect, :description)
  end

  object :move_method do
    field :name, non_null(:string)
    field :description, non_null(:string)
  end
end
