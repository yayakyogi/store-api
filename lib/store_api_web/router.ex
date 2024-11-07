defmodule StoreApiWeb.Router do
  use StoreApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {StoreApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :accepts, ["json"]
    plug StoreApiWeb.JWTAuthPlug
  end

  pipeline :role do
    plug :accepts, ["json"]
    plug StoreApiWeb.RoleAuthPlug
  end

  scope "/", StoreApiWeb do
    pipe_through :api

    get "/", AuthController, :ping
    post "/register", AuthController, :register
    post "/login", AuthController, :login
    get "/products", ProductController, :index
  end

  scope "/api/v1", StoreApiWeb do
    pipe_through [:auth, :role]

    scope "/stores" do
      post "/", StoreController, :create
      get "/:id", StoreController, :show
      put "/:id", StoreController, :update
      delete "/:id", StoreController, :delete
    end

    scope "/categories" do
      get "/", CategoryController, :index
      post "/", CategoryController, :create
      get "/:id", CategoryController, :show
      delete "/:id", CategoryController, :delete
    end

    scope "/products" do
      post "/", ProductController, :create
      put "/:id", ProductController, :update
      delete "/:id", ProductController, :delete
      post "/upload", ProductController, :upload
    end
  end

  # scope "/api" do
  #   pipe_through :api

  #   forward "/graphql", Absinthe.Plug.GraphiQL, schema: StoreApiWeb.Schema
  #   forward "/", Absinthe.Plug, schema: StoreApiWeb.Schema
  # end

  scope "/", StoreApiWeb do
    pipe_through :browser

    # get "/", PageController, :home
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:store_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: StoreApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
