defmodule LagerbehandlerWeb.PageController do
  use LagerbehandlerWeb, :controller

  alias Phoenix.LiveView

  def admin(conn, _) do
    LiveView.Controller.live_render(conn, LagerbehandlerWeb.AdminView, session: %{})
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def protected(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "protected.html", current_user: user)
  end
end
