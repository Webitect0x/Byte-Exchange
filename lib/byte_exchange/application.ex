defmodule ByteExchange.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ByteExchangeWeb.Telemetry,
      ByteExchange.Repo,
      {DNSCluster, query: Application.get_env(:byte_exchange, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ByteExchange.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ByteExchange.Finch},
      # Start a worker by calling: ByteExchange.Worker.start_link(arg)
      # {ByteExchange.Worker, arg},
      # Start to serve requests, typically the last entry
      ByteExchangeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ByteExchange.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ByteExchangeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
