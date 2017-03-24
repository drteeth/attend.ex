defmodule Attend.AttendanceManager do
  @behaviour Commanded.ProcessManagers.ProcessManager

  defstruct []

  # listen for UserRegistered => users
  # listen for PlayerJoinedTeam => teams with users
  # listen for GameScheduled => game with the two teams
  # listen for AttendanceRequested => game_id

  # I can start a process for the users and team info.
  # Maybe I can start that as start_link() and use it as a central repo?
  # Then I can start the PMs on GameScheduled

  def interested?(%GameScheduled{game_id: gid}), do: {:start, gid}
  def interested?(%AttendanceRequested{game_id: gid}), do: {:continue, gid}
  def interested?(_event), do: false

  def handle(state, %GameScheduled{} = event) do
  end

  def handle(state, %AttendanceRequested{} = event) do
  end

  def apply(state) do
  end
end
