defmodule EventSourcing.Aggregates.Appointment do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Events.AppointmentCreated
  alias EventSourcing.Events.AppointmentScheduled
  alias EventSourcing.Events.AppointmentStatusChanged

  defstruct [:appointment_id, :status, :start_datetime, :duration_in_seconds]

  # Aggregate API
  def create(appointment_id, start_datetime \\ nil) do
    [
      %AppointmentCreated{appointment_id: appointment_id},
      %AppointmentStatusChanged{appointment_id: appointment_id, status: "new"}
    ] ++
      if start_datetime do
        [%AppointmentScheduled{appointment_id: appointment_id, start_datetime: start_datetime}]
      else
        []
      end
  end

  def cancel(appointment_id) do
    %AppointmentStatusChanged{appointment_id: appointment_id, status: "canceled"}
  end

  def complete(appointment_id) do
    %AppointmentStatusChanged{appointment_id: appointment_id, status: "completed"}
  end

  def schedule(appointment_id, start_datetime) do
    [
      %AppointmentScheduled{appointment_id: appointment_id, start_datetime: start_datetime},
      %AppointmentStatusChanged{appointment_id: appointment_id, status: "scheduled"}
    ]
  end

  # State mutators

  # AppointmentCreated
  def apply(
        %Appointment{} = appointment,
        %AppointmentCreated{} = event
      ) do
    %AppointmentCreated{appointment_id: appointment_id} = event

    %Appointment{
      appointment
      | appointment_id: appointment_id
    }
  end

  # AppointmentStatusChanged
  def apply(
        %Appointment{} = appointment,
        %AppointmentStatusChanged{} = event
      ) do
    %AppointmentStatusChanged{status: status} = event

    %Appointment{
      appointment
      | status: status
    }
  end

  # AppointmentScheduled
  def apply(
        %Appointment{} = appointment,
        %AppointmentScheduled{} = event
      ) do
    %AppointmentScheduled{
      start_datetime: start_datetime
    } = event

    %Appointment{
      appointment
      | start_datetime: start_datetime
    }
  end
end
