defmodule MyAppWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room:lobby", MyAppWeb.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  

  def connect(params, socket) do
    {:ok, assign(socket, :user_id, params["user_id"])}
  end



  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     MyAppWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
