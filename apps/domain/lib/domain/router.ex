defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{
    User,
    User.RegisterUser,
    Team,
    Team.RegisterTeam,
    Team.JoinTeam,
    Team.CheckAttendance,
    Game,
    Game.ScheduleGame,
    Attendance,
    Attendance.ConfirmAttendance,
    Attendance.MarkAttendanceRequestSent,
  }

  dispatch [RegisterUser], to: User, identity: :user_id
  dispatch [RegisterTeam, JoinTeam, CheckAttendance], to: Team, identity: :team_id
  dispatch [ScheduleGame], to: Game, identity: :game_id
  dispatch [ConfirmAttendance, MarkAttendanceRequestSent], to: Attendance, identity: :attendance_id

end
