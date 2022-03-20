
defmodule EventSourcing.Projectors.AppointmentStatusChanged do
  use Commanded.Projections.Ecto,
    name: "Appointments.Projectors.AppointmentStatusChanged",
    application: EventSourcing.EventStoreApplication,
    repo: EventSourcing.Repo

  alias EventSourcing.Events.AppointmentStatusChanged
  alias EventSourcing.Projections.Appointment
  alias Ecto.{Changeset, Multi}

  project(%AppointmentStatusChanged{} = event, _metadata, fn multi ->
    IO.inspect "PROJECT STATUS CHANGE"
    with %Appointment{} = appointment <- EventSourcing.Repo.get(Appointment, event.appointment_id) do
      Multi.update(
        multi,
        :appointment,
        Changeset.change(appointment, status: event.status)
      )
    else
      _ -> multi
    end
  end)
end
