defmodule Attend.EventHandlers.TeamGames do
  @behaviour Commanded.Event.Handler

  alias Attend.{
    GameScheduled,
    TeamRegistered
  }

  defmodule TeamGames  do
    defstruct [:team_id, :name, games: []]
  end

  # TODO:
  # PlayerGames: Games by player
  # TeamGames: Games by team
  # Games: All the games
  # GamePlayers: All the players from both teams for a given game

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def handle(%GameScheduled{} = event, _metadata) do
    Agent.update(__MODULE__, fn state ->
      state
      |> Map.update!(event.home_team_id, fn team_games ->
        %TeamGames{ team_games | games: [%{game_id: event.game_id, location: event.location}]}
      end)
      |> Map.update!(event.away_team_id, fn team_games ->
        %TeamGames{ team_games | games: [%{game_id: event.game_id, location: event.location}]}
      end)
    end)
    :ok
  end

  def handle(%TeamRegistered{} = event, _metadata) do
    Agent.update(__MODULE__, fn state ->
      state
      |> Map.put(event.team_id, %TeamGames{team_id: event.team_id, name: event.name})
    end)
    :ok
  end

  def get_team_games do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def handle(_event, _metadata), do: :ok

end
