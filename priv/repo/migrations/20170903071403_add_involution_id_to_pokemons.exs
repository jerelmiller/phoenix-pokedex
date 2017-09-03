defmodule Pokedex.Repo.Migrations.AddInvolutionIdToPokemons do
  use Ecto.Migration

  def change do
    alter table(:pokemons) do
      add :involution_id, references(:pokemons, on_delete: :nothing)
    end

    create index(:pokemons, [:involution_id])
  end
end
