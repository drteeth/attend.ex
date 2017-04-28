defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{
    User, RegisterUser,
    Team, RegisterTeam, JoinTeam,
    Game, ScheduleGame,
    Attendance, CheckAttendance, ConfirmAttendance
  }

  dispatch [RegisterUser], to: User, identity: :user_id
  dispatch [RegisterTeam, JoinTeam], to: Team, identity: :team_id
  dispatch [ScheduleGame], to: Game, identity: :game_id
  dispatch [CheckAttendance, ConfirmAttendance], to: Attendance, identity: :token

end
