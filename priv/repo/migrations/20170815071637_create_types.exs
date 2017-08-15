defmodule Pokedex.Repo.Migrations.CreateTypes do
  use Ecto.Migration

  def change do
    create table(:types) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:types, [:name])
  end
end
