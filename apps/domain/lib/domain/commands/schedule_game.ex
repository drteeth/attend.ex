defmodule Attend.ScheduleGame do
  defstruct [:game_id, :location, :start, :home_team_id, :away_team_id]

  def create(location: location, start: start,
    home_team_id: home_team_id, away_team_id: away_team_id) do
    %__MODULE__{
      game_id: Attend.Id.generate(),
      location: location,
      start: start,
      home_team_id: home_team_id,
      away_team_id: away_team_id
    }
  end
end
