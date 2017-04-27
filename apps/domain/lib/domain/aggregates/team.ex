defmodule Attend.Team do
  defstruct [:id, :name, :players]

  alias Attend.{
    Team,
    AttendanceRequested
  }

  defmodule TeamRegistered, do: defstruct [:team_id, :name]
  defmodule PlayerJoinedTeam, do: defstruct [:team_id, :user_id]

  def register(%Team{} = _team, id, name) do
    %TeamRegistered{team_id: id, name: name}
  end

  def add_player(%Team{} = team, team_id, user_id) do
    # TODO Validate that the team exists?

    if Enum.member?(team.players, user_id) do
      {:error, :player_already_joined_team}
    else
      %PlayerJoinedTeam{user_id: user_id, team_id: team_id}
    end
  end

  def check_attendance(team, game_id) do
    Enum.map(team.players, fn player_id ->
      AttendanceRequested.new(
        game_id: game_id,
        team_id: team.id,
        player_id: player_id
      )
    end)
  end

  def apply(%Team{} = team, %TeamRegistered{team_id: id, name: name}) do
    %Team{team | id: id, name: name, players: []}
  end

  def apply(%Team{id: id} = team, %PlayerJoinedTeam{team_id: id, user_id: user_id}) do
    %Team{team | players: [user_id | team.players]}
  end

  def apply(%Team{id: _} = team, %AttendanceRequested{} = _event) do
    team
  end
end
