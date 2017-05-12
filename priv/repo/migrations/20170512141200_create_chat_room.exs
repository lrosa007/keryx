defmodule Keryx.Repo.Migrations.CreateKeryx.Chat.Room do
  use Ecto.Migration

  def change do
    create table(:chat_rooms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :topic, :string

      timestamps()
    end

  end
end
