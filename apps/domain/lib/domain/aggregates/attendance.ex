defmodule Attend.Attendance do
  defstruct [:id, :game_id, :team_id, :player_id, :status, :message]

  alias Attend.{
    Attendance,
    AttendanceRequested,
    Team,
  }

  alias Commanded.Aggregates.{Aggregate, Registry}

  defmodule AttendanceRequested do
    defstruct [:id, :game_id, :player_id, :team_id]
  end

  defmodule AttendanceConfirmed do
    defstruct [:id, :status, :message]
  end

  def check_attendance(%Attendance{} = _, id, game_id, team_id) do
    {:ok, team_server} = Registry.open_aggregate(Team, team_id)
    team = Aggregate.aggregate_state(team_server)

    Enum.map(team.players, fn player_id ->
      %AttendanceRequested{
        id: id,
        game_id: game_id,
        team_id: team_id,
        player_id: player_id,
      }
    end)
  end

  def confirm(%Attendance{} = attendance, status, message) do
    %AttendanceConfirmed{
      id: attendance.id,
      status: status,
      message: message,
    }
  end

  def apply(%Attendance{} = _, %AttendanceRequested{} = event) do
    %Attendance{
      id: event.id,
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
