defmodule Pokedex.Schema do
  use Absinthe.Schema
  import_types Pokedex.Schema.Types

  alias Pokedex.Resolvers

  query do
    @desc "Get a list of all pokemon"
    field :pokemons, list_of(:pokemon) do
      resolve &Resolvers.Pokemon.all/2
    end

    @desc "Get a pokemon by id"
    field :pokemon, :pokemon do
      arg :id, non_null(:id)
      resolve &Resolvers.Pokemon.find/2
    end
  end
end
