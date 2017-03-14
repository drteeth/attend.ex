defmodule Attend.Team do
  defstruct [:id, :name, :players]

  alias Attend.{Team, TeamRegistered, PlayerJoinedTeam}

  def apply(%Team{} = team, %TeamRegistered{team_id: id, name: name}) do
    %Team{team | id: id, name: name, players: []}
  end

  def apply(%Team{} = team, %PlayerJoinedTeam{team_id: id, user_id: user_id}) do
    %Team{team | players: [user_id | team.players]}
  end
end
