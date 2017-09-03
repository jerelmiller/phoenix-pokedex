defmodule Pokedex.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.Resolvers.{Lookup, Pokemon, Move}

  object :move do
    field :level, :integer

    field :accuracy, :integer,
      resolve: Lookup.path([:move, :accuracy])

    field :effect_chance, :integer,
      resolve: Lookup.path([:move, :effect_chance])

    field :name, non_null(:string),
      resolve: Lookup.path([:move, :name])

    field :power, :integer,
      resolve: Lookup.path([:move, :power])

    field :pp, non_null(:integer),
      resolve: Lookup.path([:move, :pp])

    field :effect, non_null(:string),
      resolve: &Move.effect(&1.move, &2, &3)

    field :move_method, :move_method, resolve: assoc(:move_method)
  end

  object :move_method do
    field :name, non_null(:string)
    field :description, non_null(:string)
  end

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
      resolve: Lookup.assoc_lookup(:types, :name)

    field :weaknesses, list_of(:string),
      resolve: Lookup.assoc_lookup(:weaknesses, :name)

    field :strengths, list_of(:string),
      resolve: Lookup.assoc_lookup(:strengths, :name)

    field :moves, list_of(:move), resolve: Pokemon.moves

    field :evolutions, list_of(:pokemon),
      resolve: &Pokemon.evolutions/3
  end
end
