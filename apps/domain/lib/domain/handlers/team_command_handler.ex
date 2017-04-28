defmodule Attend.TeamCommandHandler do
  @behaviour Commanded.Commands.Handler

  alias Attend.{
    Team,
    RegisterTeam,
    JoinTeam
  }

  def handle(%Team{} = team, %RegisterTeam{id: id, name: name}) do
    team |> Team.register(id, name)
  end

  def handle(%Team{} = team, %JoinTeam{user_id: user_id, team_id: team_id}) do
    team |> Team.add_player(team_id, user_id)
  end

end
