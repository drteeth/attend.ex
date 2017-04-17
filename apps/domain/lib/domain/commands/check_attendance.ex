defmodule Attend.CheckAttendance do
  defstruct [:game_id, :team_id]

  alias Attend.{Game, Team, CheckAttendance}

  def new(%Game{id: game_id}, %Team{id: team_id}) do
    new(game_id, team_id)
  end
  def new(game_id, team_id) do
    %CheckAttendance{game_id: game_id, team_id: team_id}
  end

end
