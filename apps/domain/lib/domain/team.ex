defmodule Attend.Team do
  defstruct [:id, :name]

  alias Attend.{Team, TeamRegistered}

  def apply(%Team{} = team, %TeamRegistered{team_id: id, name: name}) do
    %Team{team | id: id, name: name}
  end
end
