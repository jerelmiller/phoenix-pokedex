defmodule Pokedex.Repo.Migrations.CreatePokemonsMoves do
  use Ecto.Migration

  def change do
    create table(:pokemons_moves) do
      add :level, :integer, null: false
      add :pokemon_id, references(:pokemons, on_delete: :nothing), null: false
      add :move_id, references(:moves, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:pokemons_moves, [:pokemon_id, :move_id])
  end
end
