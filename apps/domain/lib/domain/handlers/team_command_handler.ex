defmodule Attend.TeamCommandHandler do
  @behaviour Commanded.Commands.Handler

  alias Attend.{Team, RegisterTeam, JoinTeam, CheckAttendance, ConfirmAttendance}

  def handle(%Team{} = team, %RegisterTeam{id: id, name: name}) do
    team |> Team.register(id, name)
  end

  def handle(%Team{} = team, %JoinTeam{user_id: user_id, team_id: team_id}) do
    team |> Team.add_player(team_id, user_id)
  end

  def handle(%Team{} = team, %CheckAttendance{} = command) do
    team |> Team.check_attendance(command.game_id)
  end

  def handle(%Team{} = _team, %ConfirmAttendance{} = _command) do
    # %AttendanceConfirmed{team_id: command.team_id}
  end

end
