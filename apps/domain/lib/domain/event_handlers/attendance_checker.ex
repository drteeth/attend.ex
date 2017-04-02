defmodule Attend.AttendanceChecker do
  @behaviour Commanded.Event.Handler

  alias Attend.{
    TeamRegistered,
    GameScheduled,
    UserRegistered,
    AttendanceRequested,
  }

  defmodule State do
    defstruct \
      teams: %{},
      games: %{},
      players: %{}
  end

  def start_link do
    Agent.start_link(fn -> %State{} end, name: __MODULE__)
  end

  def handle(%AttendanceRequested{} = event, _metadata) do
    Agent.get(__MODULE__, fn state ->
      player = Map.get(state.players, event.player_id)
      team = Map.get(state.teams, event.team_id)
      game = Map.get(state.games, event.game_id)

      # TODO: send an email
      # TODO: don't send an email on replay
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
    end)
    :ok
  end

  def handle(%UserRegistered{} = event, _metadata) do
    Agent.update(__MODULE__, fn state ->
      players = Map.put(state.players, event.user_id, %{name: event.name, email: event.email})
      %State{ state | players: players }
    end)
    :ok
  end

  def handle(%TeamRegistered{} = event, _metadata) do
    Agent.update(__MODULE__, fn state ->
      teams = Map.put(state.teams, event.team_id, %{name: event.name})
      %State{ state | teams: teams }
    end)
    :ok
  end

  def handle(%GameScheduled{} = event, _metadata) do
    Agent.update(__MODULE__, fn state ->
      games = Map.put(state.games, event.game_id, %{location: event.location, start: event.start})
      %State{ state | games: games }
    end)
    :ok
  end

  def handle(_event, _metadata), do: :ok

  defp mail(args) do
    # TODO: implement me
  end

end
