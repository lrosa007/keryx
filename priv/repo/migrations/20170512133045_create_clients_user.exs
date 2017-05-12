defmodule Keryx.Repo.Migrations.CreateKeryx.Clients.User do
  use Ecto.Migration

  def change do
    create table(:clients_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
