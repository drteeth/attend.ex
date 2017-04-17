defmodule Attend.GameCommandHandler do
  @behaviour Commanded.Commands.Handler

  alias Attend.{
    Game,
    ScheduleGame,
  }

  def handle(%Game{} = game, %ScheduleGame{} = command) do
    game |> Game.schedule(
      command.game_id,
      command.location,
      command.start,
      command.home_team_id,
      command.away_team_id
    )
  end

end
