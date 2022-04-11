
defmodule EventSourcing.Projectors.AppointmentProjector do
  use Commanded.Projections.Ecto,
    name: "Appointments.Projectors.AppointmentProjector",
    application: EventSourcing.EventStoreApplication,
    repo: EventSourcing.Repo,
    consistency: :strong

  alias EventSourcing.Events.AppointmentCreated
  alias EventSourcing.Events.AppointmentScheduled
  alias EventSourcing.Events.AppointmentStatusChanged

  alias EventSourcing.Projections.Appointment
  alias Ecto.{Changeset, Multi}

  project(%AppointmentCreated{} = event, _metadata, fn multi ->
    IO.inspect "PROJECT CREATED"
    Ecto.Multi.insert(multi, :appointment, %Appointment{
      uuid: event.appointment_id
    })
  end)


  project(%AppointmentScheduled{} = event, _metadata, fn multi ->
    IO.inspect "PROJECT SCHEDULED"
    with %Appointment{} = appointment <- EventSourcing.Repo.get(Appointment, event.appointment_id),
     {:ok, start_datetime, _} <- DateTime.from_iso8601(event.start_datetime) |> IO.inspect do
      IO.inspect "PROJECT SCHEDULED AND ADDED TO MULTI"

      Multi.update(
        multi,
        :appointment,
        Changeset.change(appointment, start_datetime: start_datetime)
      )
    else
      _ -> multi
    end
  end)

  project(%AppointmentStatusChanged{} = event, _metadata, fn multi ->
    IO.inspect "PROJECT STATUS CHANGE"
    with %Appointment{} = appointment <- EventSourcing.Repo.get(Appointment, event.appointment_id) do
      IO.inspect "PROJECT CHANGED AND ADDED TO MULTI"
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
