defmodule Keryx.ClientsTest do
  use Keryx.DataCase

  alias Keryx.Clients
  alias Keryx.Clients.Organization

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:organization, attrs \\ @create_attrs) do
    {:ok, organization} = Clients.create_organization(attrs)
    organization
  end

  test "list_organizations/1 returns all organizations" do
    organization = fixture(:organization)
    assert Clients.list_organizations() == [organization]
  end

  test "get_organization! returns the organization with given id" do
    organization = fixture(:organization)
    assert Clients.get_organization!(organization.id) == organization
  end

  test "create_organization/1 with valid data creates a organization" do
    assert {:ok, %Organization{} = organization} = Clients.create_organization(@create_attrs)
    assert organization.name == "some name"
  end

  test "create_organization/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Clients.create_organization(@invalid_attrs)
  end

  test "update_organization/2 with valid data updates the organization" do
    organization = fixture(:organization)
    assert {:ok, organization} = Clients.update_organization(organization, @update_attrs)
    assert %Organization{} = organization
    assert organization.name == "some updated name"
  end

  test "update_organization/2 with invalid data returns error changeset" do
    organization = fixture(:organization)
    assert {:error, %Ecto.Changeset{}} = Clients.update_organization(organization, @invalid_attrs)
    assert organization == Clients.get_organization!(organization.id)
  end

  test "delete_organization/1 deletes the organization" do
    organization = fixture(:organization)
    assert {:ok, %Organization{}} = Clients.delete_organization(organization)
    assert_raise Ecto.NoResultsError, fn -> Clients.get_organization!(organization.id) end
  end

  test "change_organization/1 returns a organization changeset" do
    organization = fixture(:organization)
    assert %Ecto.Changeset{} = Clients.change_organization(organization)
  end
end
