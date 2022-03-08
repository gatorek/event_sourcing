defmodule EventSourcing.Routers.AppointmentRouter do
  use Commanded.Commands.Router

  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CreateAppointment

  dispatch CreateAppointment,
    to: Appointment,
    identity: :appointment_id
end
