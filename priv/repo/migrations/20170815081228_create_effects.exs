defmodule Pokedex.Repo.Migrations.CreateEffects do
  use Ecto.Migration

  def change do
    create table(:effects) do
      add :description, :text, null: false

      timestamps()
    end
  end
end
