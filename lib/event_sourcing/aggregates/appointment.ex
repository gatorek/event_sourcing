defmodule EventSourcing.Aggregates.Appointment do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CancelAppointment
  alias EventSourcing.Commands.CompleteAppointment
  alias EventSourcing.Commands.CreateAppointment
  alias EventSourcing.Commands.ScheduleAppointment
  alias EventSourcing.Events.AppointmentCreated
  alias EventSourcing.Events.AppointmentScheduled
  alias EventSourcing.Events.AppointmentStatusChanged

  defstruct [:appointment_id, :status, :start_datetime, :duration_in_seconds]

  # CreateAppointment
  def execute(
        %Appointment{appointment_id: nil},
        %CreateAppointment{appointment_id: appointment_id, start_datetime: start_datetime}
      ) do

    [
      %AppointmentCreated{appointment_id: appointment_id},
      %AppointmentStatusChanged{appointment_id: appointment_id, status: "new"},
      %AppointmentScheduled{appointment_id: appointment_id, start_datetime: start_datetime}
    ]
  end

  def execute(
        %Appointment{},
        %CreateAppointment{}
      ) do
    {:error, :appointment_already_created}
  end

  # CancelAppointment
  def execute(
        %Appointment{appointment_id: appointment_id},
        %CancelAppointment{appointment_id: appointment_id}
      ) do

    %AppointmentStatusChanged{appointment_id: appointment_id, status: "canceled"}
  end

  # CompleteAppointment
  def execute(
        %Appointment{appointment_id: appointment_id},
        %CompleteAppointment{appointment_id: appointment_id}
      ) do

    %AppointmentStatusChanged{appointment_id: appointment_id, status: "completed"}
  end

  # ScheduleAppointment
  def execute(
        %Appointment{appointment_id: appointment_id},
        %ScheduleAppointment{appointment_id: appointment_id,
          start_datetime: start_datetime}
      ) do

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
    %AppointmentCreated{appointment_id: appointment_id} =
      event

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
        %AppointmentScheduled{start_datetime: nil}
      ) do

    appointment
  end

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
