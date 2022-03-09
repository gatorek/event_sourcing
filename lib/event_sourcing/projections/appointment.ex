defmodule EventSourcing.Projections.Appointment do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "appointments" do
    field :status, :string
    field :start_datetime, :utc_datetime
    field :duration_in_seconds, :integer

    timestamps()
  end
end
