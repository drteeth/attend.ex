defmodule Attend.Game do
  defstruct [:id, :location, :start, :home_team_id, :away_team_id]

  alias Attend.{
    Game,
    ScheduleGame
  }

  defmodule GameScheduled do
    defstruct [:game_id, :location, :start, :home_team_id, :away_team_id]
  end

  def execute(%Game{} = _, %ScheduleGame{} = command) do
    # TODO ensure the game is in the future
    %GameScheduled{
      game_id: command.game_id,
      location: command.location,
      start: command.start,
      home_team_id: command.home_team_id,
      away_team_id: command.away_team_id
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
