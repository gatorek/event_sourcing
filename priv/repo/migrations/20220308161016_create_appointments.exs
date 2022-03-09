defmodule EventSourcing.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :status, :string

      timestamps()
    end
  end
end
