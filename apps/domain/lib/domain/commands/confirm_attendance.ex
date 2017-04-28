defmodule Attend.ConfirmAttendance do
  defstruct [:id, :status, :message]

  alias Attend.ConfirmAttendance

  def confirm_attendance(token, status, message) do
    %ConfirmAttendance{id: token, status: status, message: message}
  end

end
