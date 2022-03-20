
defmodule EventSourcing.Projectors.AppointmentCreated do
  use Commanded.Projections.Ecto,
    name: "Appointments.Projectors.AppointmentCreated",
    application: EventSourcing.EventStoreApplication,
    repo: EventSourcing.Repo

  alias EventSourcing.Events.AppointmentCreated
  alias EventSourcing.Projections.Appointment

  project(%AppointmentCreated{} = event, _metadata, fn multi ->
    IO.inspect "PROJECT CREATED"
    Ecto.Multi.insert(multi, :appointment, %Appointment{
      uuid: event.appointment_id
    })
  end)
end
