defmodule Attend.EventHandlers.UserProjection do
  @behaviour Commanded.Event.Handler

  alias Attend.{
    User, Repo, UserReadModel, Attendance
  }

  def handle(%User.Registered{user_id: id, name: name, email: email}, _metadata) do
    case Repo.insert(%UserReadModel{id: id, name: name, email: email}) do
      {:ok, _} -> :ok
      e -> e
    end
  end

  def handle(%Attendance.Requested{} = event, _metadata) do
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

  def handle(%Attendance.Confirmed{} = _event, _metadata) do
    # TODO: update status to event.status
    # TODO: update mssage to event.message
    :ok
  end

  def handle(_event, _metadata), do: :ok

end
