defmodule MyAppWeb.RoomChannel do
	use MyAppWeb, :channel
	alias MyAppWeb.Presence


	def join("room:lobby", _params, socket) do
		send self(), :after_join
		{:ok, socket}
	end

	def handle_in("new:msg", _params, socket) do
    broadcast! socket, "new:msg", %{
    	user: _params["user"], 
    	body: _params["body"],
    	timestamp: :os.system_time(:milli_seconds)
    }
	{:noreply, socket}
  end

	def handle_info(:after_join, socket) do
    	push socket, "presence_state", Presence.list(socket)
    
    	{:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
     	online_at: inspect(System.system_time(:seconds))
    })
    {:noreply, socket}
  	end

end