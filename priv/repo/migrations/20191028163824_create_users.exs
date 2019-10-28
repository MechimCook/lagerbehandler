defmodule Lagerbehandler.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :Username, :string
      add :Password, :string

      timestamps()
    end

  end
end
