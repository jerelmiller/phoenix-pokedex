defmodule Pokedex.Repo.Migrations.CreateMoveMethods do
  use Ecto.Migration

  def change do
    create table(:move_methods) do
      add :name, :string, null: false
      add :description, :text, null: false

      timestamps()
    end

    create unique_index(:move_methods, [:name])
  end
end
