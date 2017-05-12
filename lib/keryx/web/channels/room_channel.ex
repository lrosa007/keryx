defmodule Keryx.Web.Channel do
  use Keryx.Web, :channel

  def join("room:" <> room_id, _payload, socket) do
    room = Keryx.Chat.get_room!(room_id)

    messages =
      Keryx.Chat.Message
      |> where([m], m.room_id == ^room.id)
      |> order_by([desc: :inserted_at])
      |> preload(:user)
      |> Keryx.Repo.all

    response = %{
      room: Phoenix.View.render_one(room, Keryx.Web.RoomView, "room.json"),
      messages: Phoenix.View.render_many(messages, Keryx.Web.MessageView, "message.json")
    }

    {:ok, response, assign(socket, :room, room)}
  end

  def handle_in("new_message", params, socket) do
    socket.assigns.room
    |> build_assoc(:messages, user_id: socket.assigns.user_id)
    |> Keryx.Chat.create_message(params)
    |> case do
         {:ok, message} ->
           broadcast_message(socket, message)
           {:reply, :ok, socket}
         {:error, changeset} ->
           {:reply, {:error, Phoenix.View.render(Keryx.Web.ChangesetView, "error.json", changeset: changeset)}, socket}
       end
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end

  defp broadcast_message(socket, message) do
    message = Keryx.Repo.preload(message, :user)
    rendered_message = Phoenix.View.render_one(message, Keryx.Web.MessageView, "message.json")
    broadcast!(socket, "message_created", rendered_message)
  end
end
