defmodule Keryx.Web.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room:*", Keryx.Web.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"user_id" => user_id}, socket) do
    {:ok, assign(socket, :user_id, user_id)}
  end

  def id(socket), do: "user_socket:#{socket.assigns.user_id}"
end
