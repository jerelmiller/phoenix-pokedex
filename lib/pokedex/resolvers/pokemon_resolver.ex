defmodule Pokedex.PokemonResolver do
  use Pokedex.Resolver
  use Absinthe.Ecto, repo: Pokedex.Repo

  def all(_, _) do
    {:ok, Repo.all(Pokedex.Pokemon)}
  end
end
