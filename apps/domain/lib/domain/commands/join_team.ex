defmodule Attend.JoinTeam do
  defstruct [:user_id, :team_id]

  alias Attend.JoinTeam

  def create(user_id: user_id, team_id: team_id) do
    %JoinTeam{
      user_id: user_id,
      team_id: team_id,
    }
  end
end
