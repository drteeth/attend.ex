defmodule Attend.AttendanceManager do
  @behaviour Commanded.ProcessManagers.ProcessManager

  alias Attend.{
    UserRegistered,
    AttendanceRequested,
    GameScheduled,
  }

  defstruct []

  # listen for UserRegistered => users
  # listen for PlayerJoinedTeam => teams with users
  # listen for GameScheduled => game with the two teams
  # listen for AttendanceRequested => game_id

  # def interested?(%UserRegistered{user_id: uid}), do: {:start, uid}
  # def interested?(%AttendanceRequested{game_id: gid}), do: {:continue, gid}
  def interested?(%GameScheduled{game_id: gid}), do: {:start, gid}
  def interested?(%AttendanceRequested{game_id: gid}), do: {:continue, gid}
  def interested?(_event), do: false

  def handle(_state, %GameScheduled{} = _event) do
  end

  def handle(_state, %AttendanceRequested{} = _event) do
  end

  def apply(_state, %GameScheduled{} = _event) do
  end

  def apply(_state, %AttendanceRequested{} = _event) do
  end
end
