defmodule EventSourcing.Events.AppointmentCreated do
  @derive Jason.Encoder
  defstruct [:appointment_id, :status]
end
