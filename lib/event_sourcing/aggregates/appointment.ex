defmodule EventSourcing.Aggregates.Appointment do
  alias EventSourcing.Aggregates.Appointment
  alias EventSourcing.Commands.CreateAppointment
  alias EventSourcing.Events.AppointmentCreated

  defstruct [:appointment_id, :status]

  def execute(
        %Appointment{appointment_id: nil},
        %CreateAppointment{appointment_id: appointment_id, status: status}
      ) do
    %AppointmentCreated{appointment_id: appointment_id, status: status}
  end

  # Ensure appointment was not already created
  def execute(
        %Appointment{},
        %CreateAppointment{}
      ) do
    {:error, :appointment_already_created}
  end

  # State mutators

  def apply(
        %Appointment{} = appointment,
        %AppointmentCreated{} = event
      ) do
    %AppointmentCreated{appointment_id: appointment_id, status: status} =
      event

    %Appointment{
      appointment
      | appointment_id: appointment_id,
        status: status
    }
  end
end
