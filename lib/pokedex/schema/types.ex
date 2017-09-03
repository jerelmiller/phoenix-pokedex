defmodule Pokedex.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.{Pokemon, Resolvers}

  object :move do
    field :level, :integer

    field :accuracy, :integer,
      resolve: Pokedex.Lookup.path([:move, :accuracy])

    field :effect_chance, :integer,
      resolve: Pokedex.Lookup.path([:move, :effect_chance])

    field :name, non_null(:string),
      resolve: Pokedex.Lookup.path([:move, :name])

    field :power, :integer,
      resolve: Pokedex.Lookup.path([:move, :power])

    field :pp, non_null(:integer),
      resolve: Pokedex.Lookup.path([:move, :pp])

    field :effect, non_null(:string),
      resolve: Pokedex.Lookup.path([:move, :effect, :description])

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
      resolve: Pokedex.Lookup.assoc_lookup(:types, :name)

    field :weaknesses, list_of(:string),
      resolve: Pokedex.Lookup.assoc_lookup(:weaknesses, :name)

    field :strengths, list_of(:string),
      resolve: Pokedex.Lookup.assoc_lookup(:strengths, :name)

    field :moves, list_of(:move), resolve: Resolvers.Pokemon.moves
  end
end
