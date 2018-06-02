defmodule Pokedex.Resolvers.Pokemon do
  use Pokedex.Resolver
  use Absinthe.Ecto, repo: Pokedex.Repo

  alias Pokedex.Pokemon
  alias Pokedex.Pokemon.Query

  @pounds_per_kilogram Decimal.new(2.20462)
  @feet_per_meter Decimal.new(3.28084)

  def all(_, _) do
    pokemon =
      Pokemon
      |> order_by(asc: :id)
      |> Repo.all()

    {:ok, pokemon}
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

  def image(%{number: number, name: name}, _, _) do
    {:ok, "#{base_url()}/images/#{number}#{clean_name(name)}.png"}
  end

  def weight(pokemon, %{unit: :kilogram}, _) do
    weight =
      pokemon.weight
      |> Decimal.round(2)

    {:ok, weight}
  end

  def weight(pokemon, %{unit: :pound}, _) do
    weight =
      pokemon.weight
      |> Decimal.mult(@pounds_per_kilogram)
      |> Decimal.round(2)

    {:ok, weight}
  end

  def weight(pokemon, _, _), do: weight(pokemon, %{unit: :kilogram}, nil)

  def height(pokemon, %{unit: :meter}, _) do
    height =
      pokemon.height
      |> Decimal.round(2)

    {:ok, height}
  end

  def height(pokemon, %{unit: :foot}, _) do
    height =
      pokemon.height
      |> Decimal.mult(@feet_per_meter)
      |> Decimal.round(2)

    {:ok, height}
  end

  def height(pokemon, _, _), do: height(pokemon, %{unit: :meter}, nil)

  defp preload_moves(query, _, _), do: Query.preload_moves(query)
  defp base_url, do: PokedexWeb.Endpoint.url()

  defp resolve_types(pokemon_types) do
    {:ok, Enum.map(pokemon_types, &Map.get(&1.type, :name))}
  end

  defp clean_name(name) do
    name
    |> String.replace(~r/\s/, "-")
    |> String.replace(~r/[^a-zA-Z\-]/, "")
  end
end
