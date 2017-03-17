defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{
    Router,
    RegisterUser,
    RegisterTeam,
    JoinTeam,
    Team,
    Repo,
    ReadModel.User,
  }

  alias Attend.EventHandlers.TeamProjection.Team, as: TeamRosters
  alias Attend.EventHandlers.TeamProjection.Player, as: PlayerTeams

  test "register user command" do
    register_user_command = RegisterUser.register(
      name: "Bob Ross",
      email: "user@example.com"
    )
    :ok = Router.dispatch(register_user_command)

    register_team_command = RegisterTeam.register(name: "The Penguins")
    :ok = Router.dispatch(register_team_command)

    join_team_command = %JoinTeam{
      user_id: register_user_command.id,
      team_id: register_team_command.id,
    }

    :ok = Router.dispatch(join_team_command)

    # Terrible HACK: the projection doesn't have time to run.
    :timer.sleep 100

    player = Repo.get!(PlayerTeams, register_user_command.id)
    roster = Repo.get!(TeamRosters, register_team_command.id)
    IO.inspect player
    IO.inspect roster
  end

end
