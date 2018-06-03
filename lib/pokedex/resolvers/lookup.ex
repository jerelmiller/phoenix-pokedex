defmodule Pokedex.Resolvers.Lookup do
  alias Pokedex.Repo

  def assoc_lookup(association, field) do
    fn parent, _, _ ->
      field =
        parent
        |> Ecto.assoc(association)
        |> Repo.all()
        |> Enum.map(&extract_nested_value(&1, field))

      {:ok, field}
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
