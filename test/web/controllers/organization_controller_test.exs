defmodule Keryx.Web.OrganizationControllerTest do
  use Keryx.Web.ConnCase

  alias Keryx.Clients
  alias Keryx.Clients.Organization

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:organization) do
    {:ok, organization} = Clients.create_organization(@create_attrs)
    organization
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, organization_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates organization and renders organization when data is valid", %{conn: conn} do
    conn = post conn, organization_path(conn, :create), organization: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, organization_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create organization and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, organization_path(conn, :create), organization: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen organization and renders organization when data is valid", %{conn: conn} do
    %Organization{id: id} = organization = fixture(:organization)
    conn = put conn, organization_path(conn, :update, organization), organization: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, organization_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen organization and renders errors when data is invalid", %{conn: conn} do
    organization = fixture(:organization)
    conn = put conn, organization_path(conn, :update, organization), organization: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen organization", %{conn: conn} do
    organization = fixture(:organization)
    conn = delete conn, organization_path(conn, :delete, organization)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, organization_path(conn, :show, organization)
    end
  end
end
