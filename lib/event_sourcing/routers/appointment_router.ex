defmodule EventSourcing.Routers.AppointmentRouter do
  use Commanded.Commands.Router

  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CancelAppointment
  alias EventSourcing.Commands.CompleteAppointment
  alias EventSourcing.Commands.CreateAppointment
  alias EventSourcing.Commands.ScheduleAppointment

  dispatch [CreateAppointment, CancelAppointment, CompleteAppointment, ScheduleAppointment],
    to: Appointment,
    identity: :appointment_id
end
