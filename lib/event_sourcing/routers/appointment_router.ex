defmodule EventSourcing.Routers.AppointmentRouter do
  use Commanded.Commands.Router

  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.CommandHandlers.CancelAppointmentHandler
  alias EventSourcing.CommandHandlers.CreateAppointmentHandler
  alias EventSourcing.CommandHandlers.CompleteAppointmentHandler
  alias EventSourcing.CommandHandlers.ScheduleAppointmentHandler
  alias EventSourcing.Commands.CancelAppointment
  alias EventSourcing.Commands.CompleteAppointment
  alias EventSourcing.Commands.CreateAppointment
  alias EventSourcing.Commands.ScheduleAppointment

  identify(Appointment, by: :appointment_id)

  dispatch(CancelAppointment, to: CancelAppointmentHandler, aggregate: Appointment)
  dispatch(CreateAppointment, to: CreateAppointmentHandler, aggregate: Appointment)
  dispatch(CompleteAppointment, to: CompleteAppointmentHandler, aggregate: Appointment)
  dispatch(ScheduleAppointment, to: ScheduleAppointmentHandler, aggregate: Appointment)
end
