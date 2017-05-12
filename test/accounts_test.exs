defmodule Keryx.AccountsTest do
  use Keryx.DataCase

  alias Keryx.Accounts
  alias Keryx.Accounts.Organization

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:organization, attrs \\ @create_attrs) do
    {:ok, organization} = Accounts.create_organization(attrs)
    organization
  end

  test "list_organizations/1 returns all organizations" do
    organization = fixture(:organization)
    assert Accounts.list_organizations() == [organization]
  end

  test "get_organization! returns the organization with given id" do
    organization = fixture(:organization)
    assert Accounts.get_organization!(organization.id) == organization
  end

  test "create_organization/1 with valid data creates a organization" do
    assert {:ok, %Organization{} = organization} = Accounts.create_organization(@create_attrs)
    assert organization.name == "some name"
  end

  test "create_organization/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.create_organization(@invalid_attrs)
  end

  test "update_organization/2 with valid data updates the organization" do
    organization = fixture(:organization)
    assert {:ok, organization} = Accounts.update_organization(organization, @update_attrs)
    assert %Organization{} = organization
    assert organization.name == "some updated name"
  end

  test "update_organization/2 with invalid data returns error changeset" do
    organization = fixture(:organization)
    assert {:error, %Ecto.Changeset{}} = Accounts.update_organization(organization, @invalid_attrs)
    assert organization == Accounts.get_organization!(organization.id)
  end

  test "delete_organization/1 deletes the organization" do
    organization = fixture(:organization)
    assert {:ok, %Organization{}} = Accounts.delete_organization(organization)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_organization!(organization.id) end
  end

  test "change_organization/1 returns a organization changeset" do
    organization = fixture(:organization)
    assert %Ecto.Changeset{} = Accounts.change_organization(organization)
  end
end
