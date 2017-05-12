defmodule Keryx.Web.StaffControllerTest do
  use Keryx.Web.ConnCase

  alias Keryx.Accounts
  alias Keryx.Accounts.Staff

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:staff) do
    {:ok, staff} = Accounts.create_staff(@create_attrs)
    staff
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, staff_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates staff and renders staff when data is valid", %{conn: conn} do
    conn = post conn, staff_path(conn, :create), staff: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, staff_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create staff and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, staff_path(conn, :create), staff: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen staff and renders staff when data is valid", %{conn: conn} do
    %Staff{id: id} = staff = fixture(:staff)
    conn = put conn, staff_path(conn, :update, staff), staff: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, staff_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen staff and renders errors when data is invalid", %{conn: conn} do
    staff = fixture(:staff)
    conn = put conn, staff_path(conn, :update, staff), staff: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen staff", %{conn: conn} do
    staff = fixture(:staff)
    conn = delete conn, staff_path(conn, :delete, staff)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, staff_path(conn, :show, staff)
    end
  end
end
