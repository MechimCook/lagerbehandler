defmodule LagerbehandlerWeb.UserLive.Edit do
  use Phoenix.LiveView

  alias LagerbehandlerWeb.UserLive
  alias LagerbehandlerWeb.Router.Helpers, as: Routes
  alias Lagerbehandler.UserManager

  def mount(%{path_params: %{"id" => id}}, socket) do
    user = UserManager.get_user(id)

    {:ok,
     assign(socket, %{
       count: 0,
       user: user,
       changeset: UserManager.change_user(user)
     })}
  end

  def render(assigns), do: LagerbehandlerWeb.UserView.render("edit.html", assigns)

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      socket.assigns.user
      |> Lagerbehandler.UserManager.change_user(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case UserManager.update_user(socket.assigns.user, user_params) do
      {:ok, user} ->
        {:stop,
         socket
         |> put_flash(:info, "User updated successfully.")
         |> redirect(to: Routes.live_path(socket, UserLive.Show, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
