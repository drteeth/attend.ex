defmodule Attend.Attendance do
  defstruct [:id, :game_id, :team_id, :player_id, :status, :message]

  alias Attend.{
    Attendance,
  }

  # Commands
  defmodule Request, do: defstruct [
        :attendance_id,
        :game_id,
        :team_id,
        :player_id]
  defmodule Confirm, do: defstruct [:attendance_id, :status, :message]

  # Events
  defmodule Requested, do: defstruct [
        :attendance_id,
        :game_id,
        :player_id,
        :team_id]
  defmodule Confirmed, do: defstruct [:attendance_id, :status, :message]

  # Handlers
  def execute(%{} = _attendance, %Request{} = command) do
    %Requested {
      attendance_id: command.attendance_id,
      game_id: command.game_id,
      team_id: command.team_id,
      player_id: command.player_id,
    }
  end

  def execute(%{} = _attendance, %Confirm{} = command) do
    %Confirmed {
      attendance_id: command.attendance_id,
      status: command.status,
      message: command.message,
    }
  end

  def apply(%Attendance{} = _, %Requested{} = event) do
    %Attendance {
      id: event.attendance_id,
      game_id: event.game_id,
      team_id: event.team_id,
      player_id: event.player_id,
    }
  end

  def apply(%Attendance{} = a, %Confirmed{} = event) do
    %{ a |
       status: event.status,
       message: event.message,
    }
  end

end
