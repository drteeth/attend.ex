defmodule Attend.Team do
  defstruct [:id, :name, :players]

  alias Attend.{Team, TeamRegistered, PlayerJoinedTeam}

  def register(%Team{} = _team, id, name) do
    %Attend.TeamRegistered{team_id: id, name: name}
  end

  def add_player(%Team{} = team, team_id, user_id) do
    # TODO Validate that the team exists?

    if Enum.member?(team.players, user_id) do
      {:error, :player_already_joined_team}
    else
      %PlayerJoinedTeam{user_id: user_id, team_id: team_id}
    end
  end

  def apply(%Team{} = team, %TeamRegistered{team_id: id, name: name}) do
    %Team{team | id: id, name: name, players: []}
  end

  def apply(%Team{id: id} = team, %PlayerJoinedTeam{team_id: id, user_id: user_id}) do
    %Team{team | players: [user_id | team.players]}
  end
end
