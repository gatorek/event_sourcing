defmodule EventSourcing.Events.AppointmentScheduled do
  @derive Jason.Encoder
  defstruct [:appointment_id, :start_datetime, :duration_in_seconds]
end
