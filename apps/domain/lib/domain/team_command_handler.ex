defmodule Attend.TeamCommandHandler do
  @behaviour Commanded.Commands.Handler

  def handle(%Attend.Team{}, %Attend.RegisterTeam{id: id, name: name}) do
    %Attend.TeamRegistered{team_id: id, name: name}
  end

end
