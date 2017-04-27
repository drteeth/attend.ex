defmodule Attend.Game do
  defstruct [:id, :location, :start, :home_team_id, :away_team_id]

  alias Attend.Game

  defmodule GameScheduled do
    defstruct [:game_id, :location, :start, :home_team_id, :away_team_id]
  end

  def schedule(%Game{} = _, id, location, start, home_team_id, away_team_id) do
    # TODO ensure the game is in the future
    %GameScheduled{
      game_id: id,
      location: location,
      start: start,
      home_team_id: home_team_id,
      away_team_id: away_team_id
    }
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
end
