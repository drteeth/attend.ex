defmodule Attend.GameCommandHandler do
  @behaviour Commanded.Commands.Handler

  alias Attend.{Game, ScheduleGame, CheckAttendance}

  def handle(%Game{} = game, %ScheduleGame{} = command) do
    game |> Game.schedule(
      command.game_id,
      command.location,
      command.start,
      command.home_team_id,
      command.away_team_id
    )
  end

  def handle(%Game{id: game_id} = game, %CheckAttendance{game_id: game_id} = _command) do
    game |> Game.check_attendance()
  end
end
