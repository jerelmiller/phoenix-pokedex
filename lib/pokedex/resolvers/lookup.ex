defmodule Pokedex.Resolvers.Lookup do
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.Repo

  def assoc_lookup(association, field) do
    fn (parent, _, _) ->
      ecto_batch(Repo, parent, association, fn
        records when is_list(records) ->
          {:ok, Enum.map(records, &Map.get(&1, field))}
        record ->
          {:ok, Map.get(record, field)}
      end)
    end
  end

  def path(path) when is_list(path) do
    fn (parent, _, _) ->
      {:ok, Enum.reduce(path, parent, &Map.fetch!(&2, &1))}
    end
  end
end
