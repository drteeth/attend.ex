defmodule Attend.Team do
  defstruct [:id, :name, :players]

  alias Attend.Team

  # Commands
  defmodule Register, do: defstruct [:team_id, :name]
  defmodule AddPlayer, do: defstruct [:team_id, :user_id]
  defmodule CheckAttendance, do: defstruct [:attendance_check_id, :team_id, :game_id]

  # Events
  defmodule Registered, do: defstruct [:team_id, :name]
  defmodule PlayerJoined, do: defstruct [:team_id, :user_id]
  defmodule AttendanceCheckStarted, do: defstruct [
      :attendance_check_id,
      :game_id,
      :team_id,
      player_ids: []
    ]

  def execute(%Team{} = _team, %Register{} = command) do
    %Registered{team_id: command.team_id, name: command.name}
  end

  def execute(%Team{} = team, %AddPlayer{} = command) do
    # TODO Validate that the team exists?

    if Enum.member?(team.players, command.user_id) do
      {:error, :player_already_joined_team}
    else
      %PlayerJoined{user_id: command.user_id, team_id: command.team_id}
    end
  end

  def execute(%Team{} = team, %CheckAttendance{} = command) do
    %AttendanceCheckStarted{
      attendance_check_id: command.attendance_check_id,
      game_id: command.game_id,
      team_id: command.team_id,
      player_ids: team.players
    }
  end

  def apply(%Team{} = team, %Registered{team_id: id, name: name}) do
    %Team{team | id: id, name: name, players: []}
  end

  def apply(%Team{id: id} = team, %PlayerJoined{team_id: id, user_id: user_id}) do
    %Team{team | players: [user_id | team.players]}
  end

  def apply(%Team{id: _id} = team, %AttendanceCheckStarted{} = _event) do
    # TODO: figure out what it means that this event on this aggregate
    # doesn't actually change the state.
    # I've currently got it in my head that we have to fire this event here
    # because it belongs to the team and since we're crossing over into the
    # Attendance aggregate, we'll have to use a process manager for that
    # This could be a made-up rule.
    team
  end

end
