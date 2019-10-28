defmodule LagerbehandlerWeb.Live.UserView do
  use Phoenix.LiveView

  def mount(_session, socket) do
    if connected?(socket), do: Lagerbehandler.UserManager.subscribe()
    {:ok, fetch(socket)}
  end

  def render(assigns), do: LagerbehandlerWeb.UserView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, users: Lagerbehandler.UserManager.list_users())
  end

  def handle_info({Accounts, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_user", value, socket) do
    id = Map.get(value, "value")
    user = Lagerbehandler.UserManager.get_user(id)
    {:ok, _user} = Lagerbehandler.UserManager.delete_user(user)

    {:noreply, socket}
  end
end
