defmodule Pokedex.Repo.Migrations.CreatePokemonsTypes do
  use Ecto.Migration

  def change do
    create table(:pokemons_types) do
      add :pokemon_id, references(:pokemons, on_delete: :nothing), null: false
      add :type_id, references(:types, on_delete: :nothing), null: false
      add :order, :integer, null: false

      timestamps()
    end

    create unique_index(:pokemons_types, [:pokemon_id, :type_id])
  end
end
