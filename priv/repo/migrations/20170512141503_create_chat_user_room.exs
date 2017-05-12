defmodule Keryx.Repo.Migrations.CreateKeryx.Chat.UserRoom do
  use Ecto.Migration

  def change do
    create table(:chat_user_rooms, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :user_id, references(:accounts_users, on_delete: :nothing, type: :binary_id)
      add :room_id, references(:chat_rooms, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:chat_user_rooms, [:user_id])
    create index(:chat_user_rooms, [:room_id])
  end
end
