defmodule Pokedex.Resolvers.Move do
  def effect(move, _, _) do
    description =
      move.effect.description
      |> sub_chance(move.effect_chance)
      |> replace_mechanic()

    {:ok, description}
  end

  defp sub_chance(description, chance) when is_nil(chance), do: description
  defp sub_chance(description, chance) when is_integer(chance) do
    description
    |> sub_chance(Integer.to_string(chance))
  end

  defp sub_chance(description, chance) do
    description
    |> String.replace("$effect_chance", chance, global: true)
  end

  defp replace_mechanic(description) do
    description
    |> String.replace(~r/\[([a-zA-Z]*?)\]\{.*?\}/, "\\1", global: true)
  end
end
