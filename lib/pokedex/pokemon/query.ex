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

  def ordered_types(query) do
    from pt in query,
      join: t in assoc(pt, :type),
      order_by: [pt.order],
      preload: [type: t]
  end

  def evolutions_for(query, id) do
    from p in query,
      join: e in fragment("""
        WITH RECURSIVE involutions AS (
          SELECT * FROM pokemons WHERE id = ?
          UNION ALL
          SELECT p.* FROM pokemons p JOIN involutions i ON i.involution_id = p.id
        ),
        evolutions AS (
          SELECT * from pokemons WHERE id = ?
          UNION ALL
          SELECT p.* from pokemons p JOIN evolutions e on p.involution_id = e.id
        )
        SELECT * FROM involutions
        UNION
        SELECT * FROM evolutions
        """, ^id, ^id),
      on: e.id == p.id,
      order_by: p.id
  end
end
