defmodule Keryx.Repo.Migrations.CreateKeryx.Accounts.Organization do
  use Ecto.Migration

  def change do
    create table(:accounts_organizations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
