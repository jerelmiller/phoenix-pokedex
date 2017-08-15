defmodule Pokedex.PokemonResolver do
  use Pokedex.Resolver

  def all(_, _) do
    {:ok, Repo.all(Pokedex.Pokemon)}
  end
end
