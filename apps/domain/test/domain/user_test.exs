defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{
    Router,
    RegisterUser,
    RegisterTeam,
    JoinTeam,
    Repo,
    ScheduleGame,
  }

  alias Attend.EventHandlers.TeamProjection.Team, as: TeamRosters
  alias Attend.EventHandlers.TeamProjection.Player, as: PlayerTeams

  test "register user command" do
    register_user_command = RegisterUser.register(
      name: "Bob Ross",
      email: "user@example.com"
    )
    :ok = Router.dispatch(register_user_command)

    the_penguins = RegisterTeam.register(name: "The Penguins")
    :ok = Router.dispatch(the_penguins)

    join_team_command = JoinTeam.create(
      user_id: register_user_command.id,
      team_id: the_penguins.id,
    )
    :ok = Router.dispatch(join_team_command)

    join_team_command = JoinTeam.create(
      user_id: register_user_command.id,
      team_id: the_penguins.id,
    )
    {:error, _} = Router.dispatch(join_team_command)

    the_noodles = RegisterTeam.register(name: "The Noodles")

    schedule_game_command = ScheduleGame.create(
      location: "Monarch Park: Field 1",
      start: Ecto.DateTime.utc,
      home_team_id: the_penguins.id,
      away_team_id: the_noodles.id
    )

    :ok = Router.dispatch(schedule_game_command)

    # Terrible HACK: the projection doesn't have time to run.
    :timer.sleep 100

    player = Repo.get!(PlayerTeams, register_user_command.id)
    roster = Repo.get!(TeamRosters, the_penguins.id)
    IO.inspect player
    IO.inspect roster
  end

end
