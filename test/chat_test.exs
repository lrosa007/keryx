defmodule Keryx.ChatTest do
  use Keryx.DataCase

  alias Keryx.Chat
  alias Keryx.Chat.Message

  @create_attrs %{text: "some text"}
  @update_attrs %{text: "some updated text"}
  @invalid_attrs %{text: nil}

  def fixture(:message, attrs \\ @create_attrs) do
    {:ok, message} = Chat.create_message(attrs)
    message
  end

  test "list_messages/1 returns all messages" do
    message = fixture(:message)
    assert Chat.list_messages() == [message]
  end

  test "get_message! returns the message with given id" do
    message = fixture(:message)
    assert Chat.get_message!(message.id) == message
  end

  test "create_message/1 with valid data creates a message" do
    assert {:ok, %Message{} = message} = Chat.create_message(@create_attrs)
    assert message.text == "some text"
  end

  test "create_message/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
  end

  test "update_message/2 with valid data updates the message" do
    message = fixture(:message)
    assert {:ok, message} = Chat.update_message(message, @update_attrs)
    assert %Message{} = message
    assert message.text == "some updated text"
  end

  test "update_message/2 with invalid data returns error changeset" do
    message = fixture(:message)
    assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
    assert message == Chat.get_message!(message.id)
  end

  test "delete_message/1 deletes the message" do
    message = fixture(:message)
    assert {:ok, %Message{}} = Chat.delete_message(message)
    assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
  end

  test "change_message/1 returns a message changeset" do
    message = fixture(:message)
    assert %Ecto.Changeset{} = Chat.change_message(message)
  end
end
