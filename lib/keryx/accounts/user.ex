defmodule Keryx.Accounts.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts_users" do
    field :name, :string

    belongs_to :organization, Keryx.Accounts.Organization
    many_to_many :rooms, Keryx.Chat.Room, join_through: "user_rooms"

    timestamps()
  end
end
