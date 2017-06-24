defmodule Attend.EventHandlers.UserProjection do
  @behaviour Commanded.Event.Handler

  alias Attend.{
    User.UserRegistered,
    UserReadModel,
    Repo,
    Attendance.AttendanceRequested,
    Attendance.AttendanceRequestSent,
    Attendance.AttendanceConfirmed,
  }

  def handle(%UserRegistered{user_id: id, name: name, email: email}, _metadata) do
    case Repo.insert(%UserReadModel{id: id, name: name, email: email}) do
      {:ok, _} -> :ok
      e -> e
    end
  end

  def handle(%AttendanceRequested{} = event, _metadata) do
    IO.inspect(event, label: "requested")
    player = Repo.get!(UserReadModel, event.player_id)
    attendance_checks = [event.attendance_id | player.attendance_checks]
    changeset = UserReadModel.changeset(
      player, %{
        attendance_checks: attendance_checks,
      }
    )
    case Repo.update(changeset) do
      {:ok, _} -> :ok
      e -> e
    end
    :ok
  end

  def handle(%AttendanceRequestSent{} = event, _metadata) do
    IO.inspect(event, label: "sent")
    # TODO: update status to "sent"
    :ok
  end

  def handle(%AttendanceConfirmed{} = event, _metadata) do
    IO.inspect(event, label: "confirmed")
    # TODO: update status to event.status
    # TODO: update mssage to event.message
    :ok
  end

  def handle(_event, _metadata), do: :ok

end
