defmodule Pokedex.Repo.Migrations.CreatePokemonsStrengths do
  use Ecto.Migration

  def change do
    create table(:pokemons_strengths) do
      add :pokemon_id, references(:pokemons, on_delete: :nothing), null: false
      add :type_id, references(:types, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:pokemons_strengths, [:pokemon_id, :type_id])
  end
end
