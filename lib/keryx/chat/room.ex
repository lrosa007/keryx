defmodule Keryx.Chat.Room do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chat_rooms" do
    field :name, :string
    field :topic, :string

    many_to_many :users, Keryx.Accounts.User, join_through: "chat_user_rooms"

    timestamps()
  end
end
