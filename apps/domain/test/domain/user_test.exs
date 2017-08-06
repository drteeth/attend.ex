defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{
    Router,
    User,
    Team,
    Game,
    Attendance,
    Id,
  }

  test "register user command" do
    bob_id = Id.generate()
    register_user_command = %User.Register {
      user_id: bob_id,
      name: "Bob Ross",
      email: "user@example.com"
    }
    :ok = Router.dispatch(register_user_command)

    alice_id = Id.generate()
    register_user_command = %User.Register {
      user_id: alice_id,
      name: "Alice Walker",
      email: "alice@example.com",
    }
    :ok = Router.dispatch(register_user_command)

    the_penguins = %Team.Register {
      team_id: Id.generate(),
      name: "The Penguins"
    }
    :ok = Router.dispatch(the_penguins)

    join_team_command = %Team.AddPlayer {
      team_id: the_penguins.team_id,
      user_id: bob_id,
    }
    :ok = Router.dispatch(join_team_command)

    join_team_command = %Team.AddPlayer {
      team_id: the_penguins.team_id,
      user_id: bob_id,
    }
    {:error, _} = Router.dispatch(join_team_command)

    the_noodles = %Team.Register {
      team_id: Id.generate(),
      name: "The Noodles",
    }
    :ok = Router.dispatch(the_noodles)

    game = %Game.Schedule {
      game_id: Id.generate(),
      location: "Monarch Park: Field 1",
      start: Ecto.DateTime.utc,
      home_team_id: the_penguins.team_id,
      away_team_id: the_noodles.team_id
    }
    :ok = Router.dispatch(game)

    # Home team attendance check
    check_attendance = %Team.CheckAttendance {
      attendance_check_id: Id.generate(),
      game_id: game.game_id,
      team_id: the_penguins.team_id
    }
    :ok = Router.dispatch(check_attendance)

    # # Terrible HACK: the projection doesn't have time to run.
    :timer.sleep 300

    email = hd(Attend.FakeEmailer.get_emails)

    token = email.attendance_id
    confirm_command = %Attendance.Confirm {
      attendance_id: token,
      status: "in",
      message: "I'll be 5 minutes late.",
    }
    :ok = Router.dispatch(confirm_command)

    :timer.sleep 100
  end

end
