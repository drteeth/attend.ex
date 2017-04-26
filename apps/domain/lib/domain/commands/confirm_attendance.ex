defmodule Attend.ConfirmAttendance do
  defstruct [:team_id, :token, :status, :message]

  alias Attend.ConfirmAttendance

  def confirm_attendance(token, status, message) do
    email = Attend.AttendanceChecker.find(token)
    %ConfirmAttendance{team_id: email.team_id, token: token, status: status, message: message}
  end

end
