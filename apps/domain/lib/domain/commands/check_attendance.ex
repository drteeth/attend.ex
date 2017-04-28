defmodule Attend.CheckAttendance do
  defstruct [:token, :game_id, :team_id]

  alias Attend.{Id, CheckAttendance}

  def new(game_id, team_id) do
    %CheckAttendance{
      token: Id.generate(),
      game_id: game_id,
      team_id: team_id
    }
  end

end
