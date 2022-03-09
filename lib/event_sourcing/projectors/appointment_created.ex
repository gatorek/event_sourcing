
defmodule EventSourcing.Projectors.AppointmentCreated do
  use Commanded.Projections.Ecto,
    name: "Appointments.Projectors.AppointmentCreated",
    application: EventSourcing.EventStoreApplication,
    repo: EventSourcing.Repo

  alias EventSourcing.Events.AppointmentCreated
  alias EventSourcing.Projections.Appointment

  project(%AppointmentCreated{} = event, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :appointment_created, %Appointment{
      uuid: event.appointment_id,
      status: event.status
    })
  end)
end
