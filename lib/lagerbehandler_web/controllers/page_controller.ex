defmodule LagerbehandlerWeb.PageController do
  use LagerbehandlerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def snake(conn, _) do
    conn
    |> put_layout(:game)
    |> live_render(LagerbehandlerWeb.SnakeLive, session: %{})
  end
end
