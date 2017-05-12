defmodule Keryx.Repo.Migrations.CreateKeryx.Chat.Message do
  use Ecto.Migration

  def change do
    create table(:chat_messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string, null: false

      add :user_id, references(:accounts_users, on_delete: :nothing, type: :binary_id)
      add :room_id, references(:chat_rooms, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:chat_messages, [:user_id])
    create index(:chat_messages, [:room_id])
  end
end
