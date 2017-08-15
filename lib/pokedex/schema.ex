defmodule Pokedex.Schema do
  use Absinthe.Schema
  import_types Pokedex.Schema.Types

  query do
    field :pokemons, list_of(:pokemon) do
      resolve &Pokedex.PokemonResolver.all/2
    end
  end
end
