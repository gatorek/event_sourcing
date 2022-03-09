defmodule EventSourcing.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      EventSourcing.Repo,
      # Start the Telemetry supervisor
      EventSourcingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EventSourcing.PubSub},
      # Start the Endpoint (http/https)
      EventSourcingWeb.Endpoint,
      # Start a worker by calling: EventSourcing.Worker.start_link(arg)
      # {EventSourcing.Worker, arg}
      EventSourcing.EventStoreApplication,
      EventSourcing.Projectors.AppointmentCreated
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventSourcing.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EventSourcingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
