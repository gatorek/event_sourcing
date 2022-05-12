defmodule EventSourcing.CommandHandlers.CreateAppointmentHandler do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CreateAppointment

  @behaviour Commanded.Commands.Handler

  def handle(
        %Appointment{appointment_id: nil},
        %CreateAppointment{appointment_id: appointment_id, start_datetime: start_datetime}
      ) do
    Appointment.create(appointment_id, start_datetime)
  end

  def handle(
        %Appointment{},
        %CreateAppointment{}
      ) do
    {:error, "appointment already created"}
  end
end
