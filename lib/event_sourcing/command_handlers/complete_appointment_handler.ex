defmodule EventSourcing.CommandHandlers.CompleteAppointmentHandler do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CompleteAppointment

  @behaviour Commanded.Commands.Handler

  def handle(
        %Appointment{appointment_id: appointment_id, status: "scheduled"},
        %CompleteAppointment{appointment_id: appointment_id}
      ) do
    Appointment.complete(appointment_id)
  end

  def handle(_, %CompleteAppointment{}) do
    {:error, "can complete only scheduled appointment"}
  end
end
