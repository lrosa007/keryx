defmodule Keryx.Repo.Migrations.CreateKeryx.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      add :organization_id, references(:accounts_organizations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:accounts_users, [:organization_id])
  end
end
