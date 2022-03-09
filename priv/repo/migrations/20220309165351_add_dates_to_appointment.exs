defmodule EventSourcing.Repo.Migrations.AddDatesToAppointment do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :start_datetime, :utc_datetime
      add :duration_in_seconds, :integer
    end
  end
end
