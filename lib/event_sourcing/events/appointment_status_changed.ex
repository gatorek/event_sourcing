defmodule EventSourcing.Events.AppointmentStatusChanged do
  @derive Jason.Encoder
  defstruct [:appointment_id, :status]
end
