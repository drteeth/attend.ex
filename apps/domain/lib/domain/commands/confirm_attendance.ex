defmodule Attend.ConfirmAttendance do
  defstruct [:token, :status, :message]

  alias Attend.ConfirmAttendance

  def confirm_attendance(token, status, message) do
    %ConfirmAttendance{token: token, status: status, message: message}
  end

end
