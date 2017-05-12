defmodule Keryx.Accounts.Organization do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts_organizations" do
    field :name, :string

    has_many :user, Keryx.Accounts.User

    timestamps()
  end
end
