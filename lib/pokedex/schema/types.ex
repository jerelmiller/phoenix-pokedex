defmodule Pokedex.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.Resolvers.{Lookup, Pokemon, Move}

  @desc "Units of length"
  enum :length_unit do
    value :foot
    value :meter
  end

  @desc "Units of weight"
  enum :weight_unit do
    value :kilogram
    value :pound
  end

  @desc "Represents a possible move a pokemon can acquire"
  object :move do
    @desc "The level the pokemon must reach to acquire the move"
    field :level, :integer

    @desc "Accuracy of the move"
    field :accuracy, :integer,
      resolve: Lookup.path([:move, :accuracy])

    @desc "Percent chance the move will achieve the effect"
    field :effect_chance, :integer,
      resolve: Lookup.path([:move, :effect_chance])

    @desc "Name of the move"
    field :name, non_null(:string),
      resolve: Lookup.path([:move, :name])

    @desc "Power of the move"
    field :power, :integer,
      resolve: Lookup.path([:move, :power])

    @desc "PP of the move"
    field :pp, non_null(:integer),
      resolve: Lookup.path([:move, :pp])

    @desc "Effect of the move"
    field :effect, non_null(:string),
      resolve: &Move.effect(&1.move, &2, &3)

    @desc "How the move can be acquired by the pokemon"
    field :move_method, :move_method, resolve: assoc(:move_method)
  end

  @desc "Represents how a move is acquired by a pokemon"
  object :move_method do
    field :name, non_null(:string)
    field :description, non_null(:string)
  end

  @desc "Represents a pokemon"
  object :pokemon do
    field :id, :id

    @desc "Attack power of the pokemon"
    field :attack, :integer

    @desc "Short description about the pokemon"
    field :description, :string

    @desc "Defense of the pokemon"
    field :defense, :integer

    @desc "The height of the pokemon. Default unit is meters."
    field :height, :float do
      arg :unit, :length_unit

      resolve &Pokemon.height/3
    end

    @desc "The HP of the pokemon"
    field :hp, :integer

    @desc "The pokemon's name"
    field :name, :string

    @desc "The pokedex number of the pokemon"
    field :number, :string

    @desc "Special attack of the pokemon"
    field :special_attack, :integer

    @desc "Special defense of the pokemon"
    field :special_defense, :integer

    @desc "Speed of the pokemon"
    field :speed, :integer

    @desc "Weight of the pokemon. Default unit is kilograms."
    field :weight, :float do
      arg :unit, :weight_unit

      resolve &Pokemon.weight/3
    end

    @desc "A list of the pokemon types"
    field :types, list_of(:string),
      resolve: Lookup.assoc_lookup(:types, :name)

    @desc "A list of types the pokemon is weak against"
    field :weaknesses, list_of(:string),
      resolve: Lookup.assoc_lookup(:weaknesses, :name)

    @desc "A list of types the pokemon is strong against"
    field :strengths, list_of(:string),
      resolve: Lookup.assoc_lookup(:strengths, :name)

    @desc "A list of moves the pokemon can acquire"
    field :moves, list_of(:move), resolve: Pokemon.moves

    @desc "The evolution chain for the pokemon"
    field :evolutions, list_of(:pokemon),
      resolve: &Pokemon.evolutions/3

    @desc "URL location of the image for the pokemon"
    field :image, non_null(:string),
      resolve: &Pokemon.image/3
  end
end
