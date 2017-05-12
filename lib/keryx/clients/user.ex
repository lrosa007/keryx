defmodule Keryx.Clients.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients_users" do
    field :name, :string

    timestamps()
  end
end
