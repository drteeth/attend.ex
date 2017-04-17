defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{
    Router,
    RegisterUser,
    RegisterTeam,
    JoinTeam,
    ScheduleGame,
    CheckAttendance,
  }

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
    :ok = Router.dispatch(the_noodles)

    game = ScheduleGame.create(
      location: "Monarch Park: Field 1",
      start: Ecto.DateTime.utc,
      home_team_id: the_penguins.id,
      away_team_id: the_noodles.id
    )

    :ok = Router.dispatch(game)

    # Home team attendance check
    check_attendance = CheckAttendance.new(game.game_id, the_penguins.id)
    :ok = Router.dispatch(check_attendance)

    # Terrible HACK: the projection doesn't have time to run.
    :timer.sleep 100

    # TODO: Handle user replying to an attendance check
    # Team.confirm_attendance(token, status, message)
    # AttendanceConfirmed(token, status, message)
  end

end
