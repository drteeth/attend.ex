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

  def handle(state, %GameScheduled{} = event) do
  end

  def handle(state, %AttendanceRequested{} = event) do
  end

  def apply(state, %GameScheduled{} = event) do
  end

  def apply(state, %AttendanceRequested{} = event) do
  end
end
