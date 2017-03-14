defmodule Attend.TeamCommandHandler do
  @behaviour Commanded.Commands.Handler

  def handle(%Attend.Team{}, %Attend.RegisterTeam{id: id, name: name}) do
    %Attend.TeamRegistered{team_id: id, name: name}
  end

  def handle(%Attend.Team{}, %Attend.JoinTeam{user_id: user_id, team_id: team_id}) do
    %Attend.PlayerJoinedTeam{user_id: user_id, team_id: team_id}
  end

end
