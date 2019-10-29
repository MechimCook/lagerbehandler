defmodule LagerbehandlerWeb.Live.UserView do
  use Phoenix.LiveView

  alias Lagerbehandler.UserManager

  def mount(_session, socket) do
    if connected?(socket), do: UserManager.subscribe()
    {:ok, fetch(socket)}
  end

  def render(assigns), do: LagerbehandlerWeb.UserView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, users: UserManager.list_users())
  end

  def handle_info({UserManager, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_user", value, socket) do
    id = Map.get(value, "value")
    user = UserManager.get_user(id)
    {:ok, _user} = UserManager.delete_user(user)

    {:noreply, socket}
  end
end
