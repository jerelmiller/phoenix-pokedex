defmodule Pokedex.Pokemon.Query do
  import Ecto.Query

  def preload_moves(query) do
    from pm in query,
      join: m in assoc(pm, :move),
      join: t in assoc(m, :type),
      join: e in assoc(m, :effect),
      join: mm in assoc(pm, :move_method),
      preload: [move: {m, type: t, effect: e}, move_method: mm]
  end
end
