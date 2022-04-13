defmodule EventSourcing.Routers.AppointmentRouter do
  use Commanded.Commands.Router

  alias EventSourcing.CommandHandlers.CancelAppointmentHandler
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CancelAppointment
  alias EventSourcing.Commands.CompleteAppointment
  alias EventSourcing.Commands.CreateAppointment
  alias EventSourcing.Commands.ScheduleAppointment

  dispatch [ CancelAppointment],
    to: CancelAppointmentHandler,
    aggregate: Appointment,
    identity: :appointment_id

  dispatch [CreateAppointment, CompleteAppointment, ScheduleAppointment],
    to: Appointment,
    identity: :appointment_id
end
