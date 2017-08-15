defmodule Pokedex.Repo.Migrations.CreateMoves do
  use Ecto.Migration

  def change do
    create table(:moves) do
      add :name, :string, null: false
      add :power, :integer
      add :pp, :integer, null: false
      add :accuracy, :integer
      add :effect_chance, :integer
      add :type_id, references(:types, on_delete: :nothing), null: false
      add :effect_id, references(:effects, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:moves, [:type_id])
    create index(:moves, [:effect_id])
    create unique_index(:moves, [:name])
  end
end
