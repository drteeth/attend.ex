defmodule Attend.Game do
  defstruct [:id, :location, :start, :home_team_id, :away_team_id]

  alias Attend.{Game, GameScheduled, AttendanceRequested}

  def schedule(%__MODULE__{} = _, id, location, start, home_team_id, away_team_id) do
    # TODO ensure the game is in the future
    %GameScheduled{
      game_id: id,
      location: location,
      start: start,
      home_team_id: home_team_id,
      away_team_id: away_team_id
    }
  end

  def check_attendance(%Game{id: game_id}) do
    %AttendanceRequested{game_id: game_id}
  end

  def apply(%Game{} = _, %GameScheduled{} = event) do
    %Game{
      id: event.game_id,
      location: event.location,
      start: event.start,
      home_team_id: event.home_team_id,
      away_team_id: event.away_team_id
    }
  end

  def apply(%Game{id: _game_id} = game, %AttendanceRequested{} = _event) do
    game
  end
end
