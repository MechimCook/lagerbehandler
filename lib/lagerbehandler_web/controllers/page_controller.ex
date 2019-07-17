defmodule LagerbehandlerWeb.PageController do
  use LagerbehandlerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
