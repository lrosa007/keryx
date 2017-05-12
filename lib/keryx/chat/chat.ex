defmodule Keryx.Chat do
  import Ecto.{Query, Changeset}, warn: false
  alias Keryx.Repo

  alias Keryx.Chat.Message

  def list_messages do
    Repo.all(Message)
  end

  def get_message!(id), do: Repo.get!(Message, id)

  def create_message(attrs \\ %{}) do
    %Message{}
    |> message_changeset(attrs)
    |> Repo.insert()
  end

  def update_message(%Message{} = message, attrs) do
    message
    |> message_changeset(attrs)
    |> Repo.update()
  end

  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  def change_message(%Message{} = message) do
    message_changeset(message, %{})
  end

  defp message_changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end

  alias Keryx.Chat.Room

  def list_rooms do
    Repo.all(Room)
  end

  def get_room!(id), do: Repo.get!(Room, id)

  def create_room(attrs \\ %{}) do
    %Room{}
    |> room_changeset(attrs)
    |> Repo.insert()
  end

  def update_room(%Room{} = room, attrs) do
    room
    |> room_changeset(attrs)
    |> Repo.update()
  end

  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  def change_room(%Room{} = room) do
    room_changeset(room, %{})
  end

  defp room_changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :topic])
    |> validate_required([:name, :topic])
  end

  alias Keryx.Chat.UserRoom

  def list_user_rooms do
    Repo.all(UserRoom)
  end

  def get_user_room!(id), do: Repo.get!(UserRoom, id)

  def create_user_room(attrs \\ %{}) do
    %UserRoom{}
    |> user_room_changeset(attrs)
    |> Repo.insert()
  end

  def update_user_room(%UserRoom{} = user_room, attrs) do
    user_room
    |> user_room_changeset(attrs)
    |> Repo.update()
  end

  def delete_user_room(%UserRoom{} = user_room) do
    Repo.delete(user_room)
  end

  def change_user_room(%UserRoom{} = user_room) do
    user_room_changeset(user_room, %{})
  end

  defp user_room_changeset(%UserRoom{} = user_room, attrs) do
    user_room
    |> cast(attrs, [])
    |> validate_required([])
  end
end
