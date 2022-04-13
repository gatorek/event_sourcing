defmodule EventSourcing.Handlers.AppointmentDynamic do
  @moduledoc """
  Start with:
    ```
      EventSourcing.Handlers.AppointmentDynamic.start_link(
        name: "new-UUID",
        state: %{},
        subscribe_to: "appointment-UUID"
      )
    ```
    We should init state as %Apponintment{} really, then use function common with Appointment to update state
    But how to read the handler state?
    Should we store the state somwhere else??
  """
  use Commanded.Event.Handler,
    application: EventSourcing.EventStoreApplication

    alias EventSourcing.Events.AppointmentCreated
    alias EventSourcing.Events.AppointmentScheduled
    alias EventSourcing.Events.AppointmentStatusChanged

  def init(init_param) do
    init_param = Keyword.put_new(init_param, :state, %{})
    {:ok, init_param}
  end

  def handle(
        %AppointmentCreated{appointment_id: appointment_id} = _event,
        %{state: state} = _metadata
      ) do

    new_state = Map.put(state, :appointment_id, appointment_id)
    IO.inspect(new_state, label: "HADLER STATE")

    {:ok, new_state}
  end

  def handle(
        %AppointmentStatusChanged{status: status} = _event,
        %{state: state} = _metadata
      ) do

    new_state = Map.put(state, :status, status)
    IO.inspect(new_state, label: "HADLER STATE")

    {:ok, new_state}
  end

  def handle(
        %AppointmentScheduled{start_datetime: nil} = _event,
        %{state: state} = _metadata
      ) do
        IO.inspect(state, label: "HADLER STATE")

    {:ok, state}
  end


  def handle(
        %AppointmentScheduled{start_datetime: start_datetime} = _event,
        %{state: state} = _metadata
      ) do

    new_state = Map.put(state, :start_datetime, start_datetime)
    IO.inspect(new_state, label: "HADLER STATE")

    {:ok, new_state}
  end
end
