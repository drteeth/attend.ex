defmodule Attend.JoinTeam do
  defstruct [:user_id, :team_id]

  def create(user_id: user_id, team_id: team_id) do
    %__MODULE__ {
      user_id: user_id,
      team_id: team_id,
    }
  end
end
