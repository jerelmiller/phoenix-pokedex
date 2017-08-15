defmodule Pokedex.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string, null: false
      add :number, :string, null: false
      add :description, :text

      timestamps()
    end

    create unique_index(:pokemons, [:name])
    create unique_index(:pokemons, [:number])
  end
end
