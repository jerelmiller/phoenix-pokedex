defmodule Pokedex.Resolvers.Pokemon do
  use Pokedex.Resolver
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.Query

  def all(_, _) do
    {:ok, Repo.all(Pokemon)}
  end

  def find(%{id: id}, _) do
    case Repo.get(Pokemon, id) do
      nil -> {:error, "Pokemon #{id} not found"}
      pokemon -> {:ok, pokemon}
    end
  end

  def moves, do: assoc(:pokemon_moves, &preload_moves/3)

  def evolutions(pokemon, _, _) do
    evolutions =
      Pokemon
      |> Query.evolutions_for(pokemon.id)
      |> Repo.all()

    {:ok, evolutions}
  end

  defp preload_moves(query, _, _), do: Query.preload_moves(query)
end
