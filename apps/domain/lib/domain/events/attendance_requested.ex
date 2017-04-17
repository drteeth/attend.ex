defmodule Attend.AttendanceRequested do
  defstruct [:token, :game_id, :player_id, :team_id]

  alias Attend.AttendanceRequested

  def new([game_id: game_id, team_id: team_id, player_id: player_id]) do
    %AttendanceRequested{
      token: Attend.Id.generate(),
      game_id: game_id,
      team_id: team_id,
      player_id: player_id,
    }
  end
end
