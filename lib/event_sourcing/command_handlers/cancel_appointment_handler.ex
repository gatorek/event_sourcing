defmodule EventSourcing.CommandHandlers.CancelAppointmentHandler do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CancelAppointment

  @behaviour Commanded.Commands.Handler

  def handle(%Appointment{status: "canceled"}, %CancelAppointment{}) do
    {:error, "appointment already canceled"}
  end

  def handle(%Appointment{status: "completed"}, %CancelAppointment{}) do
    {:error, "cannot cancel completed appointment"}
  end

  def handle(
    %Appointment{} = aggregate,
    %CancelAppointment{appointment_id: appointment_id})
  do
    Appointment.cancel_appointment(aggregate, appointment_id)
  end
end
