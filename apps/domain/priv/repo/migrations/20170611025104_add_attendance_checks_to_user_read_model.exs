defmodule Attend.Repo.Migrations.AddAttendanceChecksToUserReadModel do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :attendance_checks, {:array, :string}, default: []
    end
  end
end
