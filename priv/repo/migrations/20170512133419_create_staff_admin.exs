defmodule Keryx.Repo.Migrations.CreateKeryx.Staff.Admin do
  use Ecto.Migration

  def change do
    create table(:staff_admins, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
