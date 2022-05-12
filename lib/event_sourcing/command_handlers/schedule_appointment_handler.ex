defmodule EventSourcing.CommandHandlers.ScheduleAppointmentHandler do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.ScheduleAppointment

  @behaviour Commanded.Commands.Handler

  def handle(
        %Appointment{status: "canceled"},
        %ScheduleAppointment{}
      ) do
    {:error, "cannot schedule canceled appointment"}
  end

  def handle(
        %Appointment{status: "completed"},
        %ScheduleAppointment{}
      ) do
    {:error, "cannot schedule completed appointment"}
  end

  def handle(
        %Appointment{appointment_id: appointment_id},
        %ScheduleAppointment{
          appointment_id: appointment_id,
          start_datetime: %DateTime{} = start_datetime
        }
      ) do
    Appointment.schedule(appointment_id, start_datetime)
  end

  def handle(
        %Appointment{},
        %ScheduleAppointment{}
      ) do
    {:error, "invalid datetime"}
  end
end
