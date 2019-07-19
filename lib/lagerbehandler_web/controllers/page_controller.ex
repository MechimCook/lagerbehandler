defmodule LagerbehandlerWeb.PageController do
  use LagerbehandlerWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _) do
    LiveView.Controller.live_render(conn, LagerbehandlerWeb.GithubDeployView, session: %{})
  end
end
