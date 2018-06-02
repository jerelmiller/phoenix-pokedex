defmodule Pokedex.Resolvers.Lookup do
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.Repo

  def assoc_lookup(association, field) do
    fn parent, _, _ ->
      ecto_batch(Repo, parent, association, fn
        records when is_list(records) ->
          {:ok, Enum.map(records, &extract_nested_value(&1, field))}

        record ->
          {:ok, extract_nested_value(record, field)}
      end)
    end
  end

  def path(path) when is_list(path) do
    fn parent, _, _ ->
      {:ok, extract_nested_value(parent, path)}
    end
  end

  def extract_nested_value(map, path) when is_map(map) and is_list(path) do
    path
    |> Enum.reduce(map, &Map.fetch!(&2, &1))
  end

  def extract_nested_value(map, path) when is_map(map) do
    extract_nested_value(map, List.wrap(path))
  end
end
