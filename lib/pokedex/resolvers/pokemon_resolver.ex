defmodule Pokedex.PokemonResolver do
  use Pokedex.Resolver
  use Absinthe.Ecto, repo: Pokedex.Repo

  def all(_, _) do
    {:ok, Repo.all(Pokedex.Pokemon)}
  end

  def types(pokemon, _, _) do
    ecto_batch(Repo, pokemon, :types, fn types ->
      {:ok, Enum.map(types, fn type -> type.name end)}
    end)
  end
end
