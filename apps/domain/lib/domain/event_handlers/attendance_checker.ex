defmodule Attend.AttendanceChecker do
  @behaviour Commanded.ProcessManagers.ProcessManager

  alias Attend.{
    Game,
    Team,
    User,
  }

  alias Attend.Attendance.{
    AttendanceRequested,
    AttendanceRequestSent,
    AttendanceConfirmed,
    MarkAttendanceRequestSent,
  }

  alias Commanded.Aggregates.{Aggregate, Registry}

  defstruct [:token, :status]

  def interested?(%AttendanceRequested{token: token}), do: {:start, token}
  def interested?(%AttendanceRequestSent{token: token}), do: {:continue, token}
  def interested?(%AttendanceConfirmed{token: token}), do: {:stop, token}
  def interested?(_event), do: false

  def handle(_state, %AttendanceRequested{} = event) do
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
      token: event.token,
      player_id: event.player_id,
      player_name: player.name,
      email: player.email,
      team_id: event.team_id,
      team_name: team.name,
      location: game.location,
      start: game.start,
    }

    :ok = mail(attrs)
    case mail(attrs) do
      :ok -> [%MarkAttendanceRequestSent{token: event.token}]
      _ -> []
    end
  end

  def handle(state, %AttendanceRequestSent{} = _event) do
    IO.inspect state, label: :handle_sent
    []
  end

  def handle(state, %AttendanceConfirmed{}) do
    IO.inspect state, label: :handle_confirmed
    []
  end

  def apply(state, %AttendanceRequested{} = event) do
    IO.inspect state, label: :apply_requested
    %{ state | status: :requesting, token: event.token }
  end

  def apply(state, %AttendanceRequestSent{} = _event) do
    IO.inspect state, label: :apply_sent
    %{ state | status: :sent }
  end

  def apply(state, %AttendanceConfirmed{} = _event) do
    IO.inspect state, label: :apply_confirmed
    %{ state | status: :confirmed }
  end

  defp mail(_args) do
    # IO.inspect(args, label: :todo_mail)
    # Agent.update(__MODULE__, fn sent -> Map.put(sent, args.token, args) end)
    # TODO: implement actually sending an email
    :ok
  end

end
