defmodule Lagerbehandler.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :admin, :boolean
      add :departments, :string

      timestamps()
    end

  end
end
