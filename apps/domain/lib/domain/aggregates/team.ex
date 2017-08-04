defmodule Attend.Team do
  defstruct [:id, :name, :players]

  alias Attend.{
    Team,
    RegisterTeam,
    JoinTeam,
    Id,
  }

  # Commands
  defmodule RegisterTeam do
    defstruct [:team_id, :name]

    def new(name) do
      %RegisterTeam{team_id: Id.generate(), name: name}
    end
  end

  defmodule JoinTeam do
    defstruct [:team_id, :user_id]

    def new(user_id, team_id) do
      %JoinTeam{user_id: user_id, team_id: team_id}
    end
  end

  defmodule CheckAttendance do
    defstruct [:attendance_check_id, :team_id, :game_id]

    def new(game_id, team_id) do
      %CheckAttendance{game_id: game_id, team_id: team_id}
    end
  end

  # Events
  defmodule TeamRegistered, do: defstruct [:team_id, :name]
  defmodule PlayerJoinedTeam, do: defstruct [:team_id, :user_id]
  defmodule TeamAttendanceCheckStarted do
    defstruct [
      :attendance_check_id,
      :game_id,
      :team_id,
      player_ids: []
    ]
  end

  def execute(%Team{} = _team, %RegisterTeam{} = command) do
    %TeamRegistered{team_id: command.team_id, name: command.name}
  end

  def execute(%Team{} = team, %JoinTeam{} = command) do
    # TODO Validate that the team exists?

    if Enum.member?(team.players, command.user_id) do
      {:error, :player_already_joined_team}
    else
      %PlayerJoinedTeam{user_id: command.user_id, team_id: command.team_id}
    end
  end

  def execute(%Team{} = team, %CheckAttendance{} = command) do
    id = command.attendance_check_id || Id.generate()

    %TeamAttendanceCheckStarted{
      attendance_check_id: id,
      game_id: command.game_id,
      team_id: command.team_id,
      player_ids: team.players
    }
  end

  def apply(%Team{} = team, %TeamRegistered{team_id: id, name: name}) do
    %Team{team | id: id, name: name, players: []}
  end

  def apply(%Team{id: id} = team, %PlayerJoinedTeam{team_id: id, user_id: user_id}) do
    %Team{team | players: [user_id | team.players]}
  end

  def apply(%Team{id: _id} = team, %TeamAttendanceCheckStarted{} = _event) do
    # TODO: figure out what it means that this event on this aggregate
    # doesn't actually change the state.
    # I've currently got it in my head that we have to fire this event here
    # because it belongs to the team and since we're crossing over into the
    # Attendance aggregate, we'll have to use a process manager for that
    # This could be a made-up rule.
    team
  end

end
