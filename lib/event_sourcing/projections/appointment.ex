defmodule EventSourcing.Projections.Appointment do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "appointments" do
    field :status, :string

    timestamps()
  end
end
