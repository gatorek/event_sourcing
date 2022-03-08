defmodule EventSourcing.EventStoreApplication do
  use Commanded.Application, otp_app: :event_sourcing

  alias EventSourcing.Routers.AppointmentRouter

  router AppointmentRouter

  def init(config) do
    {:ok, config}
  end
end
