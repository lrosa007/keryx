defmodule Keryx.Web.MessageControllerTest do
  use Keryx.Web.ConnCase

  alias Keryx.Chat
  alias Keryx.Chat.Message

  @create_attrs %{text: "some text"}
  @update_attrs %{text: "some updated text"}
  @invalid_attrs %{text: nil}

  def fixture(:message) do
    {:ok, message} = Chat.create_message(@create_attrs)
    message
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, message_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates message and renders message when data is valid", %{conn: conn} do
    conn = post conn, message_path(conn, :create), message: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, message_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "text" => "some text"}
  end

  test "does not create message and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, message_path(conn, :create), message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen message and renders message when data is valid", %{conn: conn} do
    %Message{id: id} = message = fixture(:message)
    conn = put conn, message_path(conn, :update, message), message: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, message_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "text" => "some updated text"}
  end

  test "does not update chosen message and renders errors when data is invalid", %{conn: conn} do
    message = fixture(:message)
    conn = put conn, message_path(conn, :update, message), message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen message", %{conn: conn} do
    message = fixture(:message)
    conn = delete conn, message_path(conn, :delete, message)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, message_path(conn, :show, message)
    end
  end
end
