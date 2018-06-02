defmodule Pokedex.GenericLoader do
  def source(_) do
    Dataloader.Ecto.new(
      Pokedex.Repo,
      query: &__MODULE__.query/2
    )
  end

  def query(query, _), do: query
end
