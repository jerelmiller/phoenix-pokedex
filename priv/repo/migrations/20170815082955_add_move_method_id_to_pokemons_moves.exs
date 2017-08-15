defmodule Pokedex.Repo.Migrations.AddMoveMethodIdToPokemonsMoves do
  use Ecto.Migration

  def change do
    alter table(:pokemons_moves) do
      add :move_method_id, references(:move_methods, on_delete: :nothing), null: false
    end

    drop unique_index(:pokemons_moves, [:pokemon_id, :move_id])
    create index(:pokemons_moves, [:pokemon_id])
    create index(:pokemons_moves, [:move_id])
    create index(:pokemons_moves, [:move_method_id])
  end
end
