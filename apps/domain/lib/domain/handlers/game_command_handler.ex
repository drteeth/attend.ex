defmodule Attend.GameCommandHandler do
  @behaviour Commanded.Commands.Handler

  alias Attend.{
    User,
    Team,
    Game,
    ScheduleGame,
    CheckAttendance,
    AttendanceRequested,
  }

  def handle(%Game{} = game, %ScheduleGame{} = command) do
    game |> Game.schedule(
      command.game_id,
      command.location,
      command.start,
      command.home_team_id,
      command.away_team_id
    )
  end

  def handle(%Game{id: game_id} = game, %CheckAttendance{game_id: game_id} = _command) do
    # TODO: move all of this goo out to it's own module

    # load the home team
    {:ok, home_team_events} = EventStore.read_stream_forward(game.home_team_id)
    home_team = List.foldl(home_team_events, %Team{}, fn (event, team) ->
      Team.apply(team, event.data)
    end)

    home_team_players = Enum.map(home_team.players, fn player_id ->
      {:ok, player_events} = EventStore.read_stream_forward(player_id)
      List.foldl(player_events, %User{}, fn (event, player) ->
        User.apply(player, event.data)
      end)
    end)

    # load the away team
    {:ok, away_team_events} = EventStore.read_stream_forward(game.away_team_id)
    away_team = List.foldl(away_team_events, %Team{}, fn (event, team) ->
      Team.apply(team, event.data)
    end)
    away_team_players = Enum.map(away_team.players, fn player_id ->
      {:ok, player_events} = EventStore.read_stream_forward(player_id)
      List.foldl(player_events, %User{}, fn (event, player) ->
        User.apply(player, event.data)
      end)
    end)

    events = Enum.map(away_team_players, fn player ->
      %AttendanceRequested{
        token: Attend.Id.generate(),
        player_id: player.id,
        game_id: game.id,
        team_id: away_team.id,
      }
    end)

    events ++ Enum.map(home_team_players, fn player ->
      %AttendanceRequested{
        token: Attend.Id.generate(),
        player_id: player.id,
        game_id: game.id,
        team_id: home_team.id,
      }
    end)
  end
end
