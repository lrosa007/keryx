defmodule Keryx.StaffTest do
  use Keryx.DataCase

  alias Keryx.Staff
  alias Keryx.Staff.User

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:user, attrs \\ @create_attrs) do
    {:ok, user} = Staff.create_user(attrs)
    user
  end

  test "list_users/1 returns all users" do
    user = fixture(:user)
    assert Staff.list_users() == [user]
  end

  test "get_user! returns the user with given id" do
    user = fixture(:user)
    assert Staff.get_user!(user.id) == user
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Staff.create_user(@create_attrs)
    assert user.name == "some name"
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Staff.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = fixture(:user)
    assert {:ok, user} = Staff.update_user(user, @update_attrs)
    assert %User{} = user
    assert user.name == "some updated name"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture(:user)
    assert {:error, %Ecto.Changeset{}} = Staff.update_user(user, @invalid_attrs)
    assert user == Staff.get_user!(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = fixture(:user)
    assert {:ok, %User{}} = Staff.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Staff.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = fixture(:user)
    assert %Ecto.Changeset{} = Staff.change_user(user)
  end
end
