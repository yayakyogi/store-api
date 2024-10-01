defmodule StoreApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StoreApiWeb.Telemetry,
      StoreApi.Repo,
      {DNSCluster, query: Application.get_env(:store_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StoreApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: StoreApi.Finch},
      # Start a worker by calling: StoreApi.Worker.start_link(arg)
      # {StoreApi.Worker, arg},
      # Start to serve requests, typically the last entry
      StoreApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StoreApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StoreApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
