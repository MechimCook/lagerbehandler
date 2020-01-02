defmodule LagerbehandlerWeb.Plugs.Admin do
  import Plug.Conn

  alias Lagerbehandler.Repo
  alias Lagerbehandler.UserManager.User

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = conn.private.guardian_default_resource.id
    current_user = Repo.get(User, user_id)

    cond do
      current_user.admin ->
        conn =
          conn
          |> assign(:admin, true)

        conn

      true ->
        send_resp(conn, 401, "unautherized")
    end
  end
end
