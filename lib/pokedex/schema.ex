defmodule Pokedex.Schema do
  use Absinthe.Schema
  import_types Pokedex.Schema.Types

  alias Pokedex.Resolvers

  query do
    field :pokemons, list_of(:pokemon) do
      resolve &Resolvers.Pokemon.all/2
    end

    field :pokemon, :pokemon do
      arg :id, non_null(:id)
      resolve &Resolvers.Pokemon.find/2
    end
  end
end
