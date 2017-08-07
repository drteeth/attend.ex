defmodule Attend.AttendanceChecker do
  @behaviour Commanded.ProcessManagers.ProcessManager

  alias Attend.{
    Game,
    Team,
    User,
    Attendance
  }

  alias Commanded.Aggregates.{Aggregate, Registry}

  defstruct [:attendance_id, :status]

  def interested?(%Attendance.Requested{attendance_id: id}), do: {:start, id}
  def interested?(%Attendance.Confirmed{attendance_id: id}), do: {:stop, id}
  def interested?(_event), do: false

  def handle(_state, %Attendance.Requested{} = event) do
    # TODO: send an email
    # TODO: don't send an email on replay

    # TODO: update this when the Elixir Registry version of Commanded drops
    {:ok, game_server} = Registry.open_aggregate(Game, event.game_id)
    game = Aggregate.aggregate_state(game_server)

    {:ok, user_server} = Registry.open_aggregate(User, event.player_id)
    player = Aggregate.aggregate_state(user_server)

    {:ok, team_server} = Registry.open_aggregate(Team, event.team_id)
    team = Aggregate.aggregate_state(team_server)

    attrs = %{
      attendance_id: event.attendance_id,
      player_id: event.player_id,
      player_name: player.name,
      email: player.email,
      team_id: event.team_id,
      team_name: team.name,
      location: game.location,
      start: game.start,
    }

    mail(attrs)

    []
  end

  def handle(_state, %Attendance.Confirmed{}) do
    []
  end

  def apply(state, %Attendance.Requested{} = event) do
    %{ state | status: :requesting, attendance_id: event.attendance_id }
  end

  def apply(state, %Attendance.Confirmed{} = _event) do
    %{ state | status: :confirmed }
  end

  defp mail(args) do
    # TODO: implement actually sending an email
    Attend.FakeEmailer.send_email(args)
    :ok
  end

end
