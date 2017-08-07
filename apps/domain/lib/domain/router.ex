defmodule Attend.Router do
  use Commanded.Commands.Router

  middleware Commanded.Middleware.Logger

  alias Attend.{User, Team, Game, Attendance}

  dispatch [User.Register], to: User, identity: :user_id

  dispatch [Game.Schedule], to: Game, identity: :game_id

  dispatch [
    Team.Register,
    Team.AddPlayer,
    Team.CheckAttendance
  ], to: Team, identity: :team_id

  dispatch [
    Attendance.Request,
    Attendance.Confirm,
  ], to: Attendance, identity: :attendance_id
end
