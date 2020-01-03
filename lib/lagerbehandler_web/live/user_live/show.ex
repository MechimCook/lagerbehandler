defmodule LagerbehandlerWeb.UserLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias LagerbehandlerWeb.UserLive
  alias LagerbehandlerWeb.Router.Helpers, as: Routes
  alias Lagerbehandler.UserManager
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h1>Show User</h1>

    <ul>

      <li>
        <strong>Username:</strong>
        <%= @user.username %>
      </li>

      <li>
        <strong>department:</strong>
        <%= @user.departments %>
      </li>
      <li>
        <strong>admin:</strong>
        <%= @user.admin %>
      </li>
    </ul>
    <span><%= link "Edit", to: Routes.live_path(@socket, UserLive.Edit, @user) %></span>
    <span><%= link "Back", to: Routes.live_path(@socket, UserLive.Index) %></span>
    """
  end

  def mount(%{path_params: %{"id" => id}}, socket) do
    if connected?(socket), do: Lagerbehandler.UserManager.subscribe(id)
    {:ok, fetch(assign(socket, id: id))}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, user: UserManager.get_user(id))
  end

  def handle_info({UserManager, [:user, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({UserManager, [:user, :deleted], _}, socket) do
    {:stop,
     socket
     |> put_flash(:error, "This user has been deleted from the system")
     |> redirect(to: Routes.live_path(socket, UserLive.Index))}
  end
end
