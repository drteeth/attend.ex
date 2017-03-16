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

  test "register user command" do
    register_user_command = RegisterUser.register(
      name: "Ben Moss",
      email: "drteeth@gmail.com"
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

    user = Repo.get!(User, register_user_command.id)
    assert user.id == register_user_command.id
    assert user.name == "Ben Moss"
    assert user.email == "drteeth@gmail.com"
  end

end
