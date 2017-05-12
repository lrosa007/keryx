defmodule Keryx.Chat.UserRoom do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chat_user_rooms" do
    belongs_to :user, Keryx.Accounts.User
    belongs_to :room, Keryx.Chat.Room

    timestamps()
  end
end
