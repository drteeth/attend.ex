defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{
    Router,
    RegisterUser,
    RegisterTeam,
    JoinTeam,
    Team,
  }

  test "register user command" do
    register_user_command = RegisterUser.register(name: "Ben Moss", email: "drteeth@gmail.com")
    :ok = Router.dispatch(register_user_command)

    register_team_command = RegisterTeam.register(name: "The Penguins")
    :ok = Router.dispatch(register_team_command)

    join_team_command = %JoinTeam{
      user_id: register_user_command.id,
      team_id: register_team_command.id,
    }

    :ok = Router.dispatch(join_team_command)

    {:ok, events} = EventStore.read_stream_forward(register_team_command.id)
    team = List.foldl(events, %Team{}, fn (event, team) ->
      Team.apply(team, event.data)
    end)

    IO.inspect(team)
  end

end
