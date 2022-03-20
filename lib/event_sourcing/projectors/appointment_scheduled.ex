
defmodule EventSourcing.Projectors.AppointmentScheduled do
  use Commanded.Projections.Ecto,
    name: "Appointments.Projectors.AppointmentScheduled",
    application: EventSourcing.EventStoreApplication,
    repo: EventSourcing.Repo

  alias EventSourcing.Events.AppointmentScheduled
  alias EventSourcing.Projections.Appointment
  alias Ecto.{Changeset, Multi}

  project(%AppointmentScheduled{} = event, _metadata, fn multi ->
    IO.inspect "PROJECT SCHEDULED"
    with %Appointment{} = appointment <- EventSourcing.Repo.get(Appointment, event.appointment_id),
      {:ok, start_datetime, _} <- DateTime.from_iso8601(event.start_datetime) do
      Multi.update(
        multi,
        :appointment,
        Changeset.change(appointment, start_datetime: start_datetime)
      )
    else
      _ -> multi
    end
  end)
end
