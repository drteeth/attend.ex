defmodule Attend.Team do
  defstruct [:id, :name, :players]

  alias Attend.{
    Team,
    RegisterTeam,
    JoinTeam,
    Id,
    Attendance.AttendanceRequested,
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
    defstruct [:team_id, :game_id]

    def new(game_id, team_id) do
      %CheckAttendance{game_id: game_id, team_id: team_id}
    end
  end

  # Events
  defmodule TeamRegistered, do: defstruct [:team_id, :name]
  defmodule PlayerJoinedTeam, do: defstruct [:team_id, :user_id]

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
    Enum.map(team.players, fn player_id ->
      %AttendanceRequested{
        attendance_id: Id.generate(),
        game_id: command.game_id,
        team_id: team.id,
        player_id: player_id,
      }
    end)
  end

  def apply(%Team{} = team, %TeamRegistered{team_id: id, name: name}) do
    %Team{team | id: id, name: name, players: []}
  end

  def apply(%Team{id: id} = team, %PlayerJoinedTeam{team_id: id, user_id: user_id}) do
    %Team{team | players: [user_id | team.players]}
  end

  def apply(team, %AttendanceRequested{} = event) do
    team
  end
end
