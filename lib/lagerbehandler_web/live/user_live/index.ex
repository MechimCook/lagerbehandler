defmodule LagerbehandlerWeb.UserLive.Index do
  use Phoenix.LiveView

  alias Lagerbehandler.UserManager
  alias LagerbehandlerWeb.UserView

  def mount(_session, socket) do
    if connected?(socket), do: Lagerbehandler.UserManager.subscribe()
    {:ok, fetch(socket)}
  end

  def render(assigns), do: UserView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, users: UserManager.list_users())
  end

  def handle_info({UserManager, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_user", id, socket) do
    user = UserManager.get_user(id)
    {:ok, _user} = UserManager.delete_user(user)

    {:noreply, socket}
  end
end
