defmodule Attend.Attendance do
  defstruct [:id, :game_id, :team_id, :player_id, :status, :message]

  alias Attend.{
    Attendance,
    ConfirmAttendance,
    AttendanceRequested,
    Team,
    Id,
  }

  alias Commanded.Aggregates.{Aggregate, Registry}

  # Commands
  defmodule MarkAttendanceRequestSent, do: defstruct [:attendance_id]

  defmodule ConfirmAttendance do
    defstruct [:attendance_id, :status, :message]

    def new(attendance_id, status, message) do
      %ConfirmAttendance{attendance_id: attendance_id, status: status, message: message}
    end
  end

  # Events
  defmodule AttendanceRequested do
    defstruct [:attendance_id, :game_id, :player_id, :team_id]
  end

  defmodule AttendanceRequestSent, do: defstruct [:attendance_id]

  defmodule AttendanceConfirmed do
    defstruct [:attendance_id, :status, :message]
  end

  def execute(%Attendance{} = attendance, %MarkAttendanceRequestSent{} = command) do
    %AttendanceRequestSent{attendance_id: command.attendance_id}
  end

  def execute(%Attendance{} = attendance, %ConfirmAttendance{} = command) do
    %AttendanceConfirmed{
      attendance_id: attendance.id,
      status: command.status,
      message: command.message,
    }
  end

  def apply(%Attendance{} = _, %AttendanceRequested{} = event) do
    %Attendance{
      id: event.attendance_id,
      game_id: event.game_id,
      team_id: event.team_id,
      player_id: event.player_id,
    }
  end

  def apply(%Attendance{} = a, %AttendanceRequestSent{} = event ) do
    %{ a | status: "sent" }
  end

  def apply(%Attendance{} = a, %AttendanceConfirmed{} = event) do
    %{ a |
       status: event.status,
       message: event.message,
    }
  end

end
