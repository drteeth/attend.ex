defmodule Attend.Attendance do
  defstruct [:id, :game_id, :team_id, :player_id, :status, :message]

  alias Attend.{
    Attendance,
    CheckAttendance,
    ConfirmAttendance,
    AttendanceRequested,
    Team,
  }

  alias Commanded.Aggregates.{Aggregate, Registry}

  defmodule AttendanceRequested do
    defstruct [:token, :game_id, :player_id, :team_id]
  end

  defmodule AttendanceConfirmed do
    defstruct [:token, :status, :message]
  end

  def execute(%Attendance{} = _, %CheckAttendance{} = command) do
    {:ok, team_server} = Registry.open_aggregate(Team, command.team_id)
    team = Aggregate.aggregate_state(team_server)

    Enum.map(team.players, fn player_id ->
      %AttendanceRequested{
        token: command.token,
        game_id: command.game_id,
        team_id: command.team_id,
        player_id: player_id,
      }
    end)
  end

  def execute(%Attendance{} = attendance, %ConfirmAttendance{} = command) do
    %AttendanceConfirmed{
      token: attendance.id,
      status: command.status,
      message: command.message,
    }
  end

  def apply(%Attendance{} = _, %AttendanceRequested{} = event) do
    %Attendance{
      id: event.token,
      game_id: event.game_id,
      team_id: event.team_id,
      player_id: event.player_id,
    }
  end

  def apply(%Attendance{} = a, %AttendanceConfirmed{} = event) do
    %{ a |
       status: event.status,
       message: event.message,
    }
  end

end
