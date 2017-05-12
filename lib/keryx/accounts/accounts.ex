defmodule Keryx.Accounts do
  import Ecto.{Query, Changeset}, warn: false
  alias Keryx.Repo

  alias Keryx.Accounts.Organization

  def list_organizations do
    Repo.all(Organization)
  end

  def get_organization!(id), do: Repo.get!(Organization, id)

  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> organization_changeset(attrs)
    |> Repo.insert()
  end

  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> organization_changeset(attrs)
    |> Repo.update()
  end

  def delete_organization(%Organization{} = organization) do
    Repo.delete(organization)
  end

  def change_organization(%Organization{} = organization) do
    organization_changeset(organization, %{})
  end

  defp organization_changeset(%Organization{} = organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  alias Keryx.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> user_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> user_changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    user_changeset(user, %{})
  end

  defp user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  alias Keryx.Accounts.Staff

  def list_staffs do
    Repo.all(Staff)
  end

  def get_staff!(id), do: Repo.get!(Staff, id)

  def create_staff(attrs \\ %{}) do
    %Staff{}
    |> staff_changeset(attrs)
    |> Repo.insert()
  end

  def update_staff(%Staff{} = staff, attrs) do
    staff
    |> staff_changeset(attrs)
    |> Repo.update()
  end

  def delete_staff(%Staff{} = staff) do
    Repo.delete(staff)
  end

  def change_staff(%Staff{} = staff) do
    staff_changeset(staff, %{})
  end

  defp staff_changeset(%Staff{} = staff, attrs) do
    staff
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
