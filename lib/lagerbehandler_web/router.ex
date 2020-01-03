defmodule LagerbehandlerWeb.Router do
  use LagerbehandlerWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Lagerbehandler.UserManager.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :admin do
    plug LagerbehandlerWeb.Plugs.Admin
  end

  scope "/", LagerbehandlerWeb do
    pipe_through [:browser, :auth]

    get "/", SessionController, :new

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  # Definitely logged in scope
  scope "/", LagerbehandlerWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/protected", PageController, :protected

    scope "/admin" do
      pipe_through [:admin]

      get "/", PageController, :admin

      live "/users", UserLive.Index
      live "/users/new", UserLive.New
      live "/users/:id", UserLive.Show, session: [:path_params]
      live "/users/:id/edit", UserLive.Edit, session: [:path_params]

      resources "/plain/users", UserController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LagerbehandlerWeb do
  #   pipe_through :api
  # end
end
