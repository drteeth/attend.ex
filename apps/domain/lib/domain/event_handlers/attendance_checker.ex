defmodule Attend.AttendanceChecker do
  @behaviour Commanded.Event.Handler

  alias Attend.{
    Game,
    Team,
    User,
    Team.AttendanceRequested,
  }
  alias Commanded.Aggregates.{Aggregate, Registry}

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def handle(%AttendanceRequested{} = event, _metadata) do
    # TODO: send an email
    # TODO: don't send an email on replay

    # TODO: update this when the Elixir Registry version of Commanded drops
    {:ok, game_server} = Registry.open_aggregate(Game, event.game_id)
    {:ok, user_server} = Registry.open_aggregate(User, event.player_id)
    {:ok, team_server} = Registry.open_aggregate(Team, event.team_id)
    game = Aggregate.aggregate_state(game_server)
    player = Aggregate.aggregate_state(user_server)
    team = Aggregate.aggregate_state(team_server)

    mail(%{
          token: event.token,
          player_id: event.player_id,
          player_name: player.name,
          email: player.email,
          team_id: event.team_id,
          team_name: team.name,
          location: game.location,
          start: game.start,
         })
    :ok
  end

  def handle(_event, _metadata), do: :ok

  def sent_mail do
    Agent.get(__MODULE__, fn sent -> Map.values(sent) end)
  end

  def find(token) do
    Agent.get(__MODULE__, fn sent -> Map.get(sent, token) end)
  end

  defp mail(args) do
    # IO.inspect(args, label: :todo_mail)
    Agent.update(__MODULE__, fn sent -> Map.put(sent, args.token, args) end)
    # TODO: implement me
  end

end
