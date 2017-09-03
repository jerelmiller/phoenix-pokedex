defmodule Pokedex.Resolvers.Pokemon do
  use Pokedex.Resolver
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.Pokemon.Query

  def all(_, _) do
    {:ok, Repo.all(Pokedex.Pokemon)}
  end

  def moves, do: assoc(:pokemon_moves, &preload_moves/3)

  defp preload_moves(query, _, _), do: Query.preload_moves(query)
end
