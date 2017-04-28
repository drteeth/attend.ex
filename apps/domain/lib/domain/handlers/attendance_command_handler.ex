defmodule Attend.AttendanceCommandHandler do

  alias Attend.{
    Attendance,
    CheckAttendance,
    ConfirmAttendance,
  }

  def handle(%Attendance{} = state, %CheckAttendance{} = cmd) do
    state
    |> Attendance.check_attendance(cmd.id, cmd.game_id, cmd.team_id)
  end

  def handle(%Attendance{} = attendance, %ConfirmAttendance{} = command) do
    attendance |> Attendance.confirm(command.status, command.message)
  end

end
