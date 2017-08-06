defmodule Attend.Game do
  # TODO: Implement cancelation of games
  defstruct [:id, :location, :start, :home_team_id, :away_team_id]

  alias Attend.Game

  # Commands
  defmodule Schedule, do: defstruct [
        :game_id,
        :location,
        :start,
        :home_team_id,
        :away_team_id]

  # Events
  defmodule Scheduled, do: defstruct [
        :game_id,
        :location,
        :start,
        :home_team_id,
        :away_team_id]

  # Handlers
  def execute(%Game{} = _, %Schedule{} = command) do
    # TODO ensure the game is in the future
    %Scheduled{
      game_id: command.game_id,
      location: command.location,
      start: command.start,
      home_team_id: command.home_team_id,
      away_team_id: command.away_team_id
    }
  end

  def apply(%Game{} = _, %Scheduled{} = event) do
    %Game{
      id: event.game_id,
      location: event.location,
      start: event.start,
      home_team_id: event.home_team_id,
      away_team_id: event.away_team_id
    }
  end
end
