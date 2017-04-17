defmodule Attend.AttendanceChecker do
  @behaviour Commanded.Event.Handler

  alias Attend.{
    Game,
    Team,
    User,
    AttendanceRequested,
  }
  alias Commanded.Aggregates.{Aggregate, Registry}

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

  defp mail(args) do
    IO.inspect(args, label: :todo_mail)
    # TODO: implement me
  end

end
