defmodule EventSourcing.Commands.CreateAppointment do
  defstruct [:appointment_id, start_datetime: nil]
end
