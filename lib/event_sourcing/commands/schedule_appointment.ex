defmodule EventSourcing.Commands.ScheduleAppointment do
  defstruct [:appointment_id, start_datetime: nil]
end
