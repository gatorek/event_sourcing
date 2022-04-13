defmodule EventSourcing.CommandHandlers.CancelAppointmentHandler do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CancelAppointment

  @behaviour Commanded.Commands.Handler

  def handle(%Appointment{} = aggregate, %CancelAppointment{} = command) do
    %CancelAppointment{appointment_id: appointment_id} = command

    Appointment.cancel_appointment(aggregate, appointment_id)
  end
end
