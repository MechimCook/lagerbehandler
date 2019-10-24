defmodule Lagerbehandler.UserManager.ErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    body = to_string(type)
    IO.puts(reason)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end
