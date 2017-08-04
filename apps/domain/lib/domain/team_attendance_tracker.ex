defmodule Attend.TeamAttendanceTracker do
  @behaviour Commanded.ProcessManagers.ProcessManager

  alias Attend.{
    Team,
    Id,
    Team.TeamAttendanceCheckStarted,
    Attendance.RequestAttendance,
  }

  alias Commanded.Aggregates.{Aggregate, Registry}

  defstruct [:team_id, :game_id, players: []]

  def interested?(%TeamAttendanceCheckStarted{team_id: id}), do: {:start, id}
  def interested?(_), do: false

  def handle(_check, %TeamAttendanceCheckStarted{} = event) do
    {:ok, server} = Registry.open_aggregate(Team, event.team_id)
    team = Aggregate.aggregate_state(server)

    team.players
    |> Enum.map(fn player_id ->
      %RequestAttendance {
        attendance_id: Id.generate(),
        game_id: event.game_id,
        team_id: event.team_id,
        player_id: player_id
      }
    end)
  end

  def apply(check, %TeamAttendanceCheckStarted{} = _event) do
    # TODO: keep state :]
    check
  end
end

# Team
#   Registered(team_id, name)
#   PlayerJoinedTeam(team_id, player_id)  <-----------------
#                                                           |
# Game                                                      |
#   Scheduled(game_id, home_team_id, away_team_id, ...)     |
#                                                           |
# Attendance                                                |
#   TeamAttendanceCheckStarted(id, team_id, game_id)        |
#   AttendanceRequested(id, team_id, game_id, player_id) ---
#      ^^^ need to fire one of these per player on the team
