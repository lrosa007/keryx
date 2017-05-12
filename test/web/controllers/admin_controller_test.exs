defmodule Keryx.Web.AdminControllerTest do
  use Keryx.Web.ConnCase

  alias Keryx.Staff
  alias Keryx.Staff.Admin

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:admin) do
    {:ok, admin} = Staff.create_admin(@create_attrs)
    admin
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates admin and renders admin when data is valid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), admin: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, admin_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create admin and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), admin: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen admin and renders admin when data is valid", %{conn: conn} do
    %Admin{id: id} = admin = fixture(:admin)
    conn = put conn, admin_path(conn, :update, admin), admin: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, admin_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen admin and renders errors when data is invalid", %{conn: conn} do
    admin = fixture(:admin)
    conn = put conn, admin_path(conn, :update, admin), admin: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen admin", %{conn: conn} do
    admin = fixture(:admin)
    conn = delete conn, admin_path(conn, :delete, admin)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, admin_path(conn, :show, admin)
    end
  end
end
