defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{
    User, User.RegisterUser,
    Team, Team.RegisterTeam, Team.JoinTeam,
    Game, Game.ScheduleGame,
    Attendance, Attendance.CheckAttendance, Attendance.ConfirmAttendance, Attendance.MarkAttendanceRequestSent,
  }

  dispatch [RegisterUser], to: User, identity: :user_id
  dispatch [RegisterTeam, JoinTeam], to: Team, identity: :team_id
  dispatch [ScheduleGame], to: Game, identity: :game_id
  dispatch [CheckAttendance, ConfirmAttendance, MarkAttendanceRequestSent], to: Attendance, identity: :token

end
