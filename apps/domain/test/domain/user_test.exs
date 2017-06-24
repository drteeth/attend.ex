defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{
    Router,
    User.RegisterUser,
    Team.RegisterTeam,
    Team.JoinTeam,
    Team.CheckAttendance,
    Game.ScheduleGame,
    UserReadModel,
    Repo,
    Attendance.ConfirmAttendance,
  }

  import Ecto.Query, only: [from: 2]

  test "register user command" do
    register_user_command = RegisterUser.new("Bob Ross", "user@example.com")
    :ok = Router.dispatch(register_user_command)

    the_penguins = RegisterTeam.new("The Penguins")
    :ok = Router.dispatch(the_penguins)

    join_team_command = JoinTeam.new(
      register_user_command.user_id,
      the_penguins.team_id
    )
    :ok = Router.dispatch(join_team_command)

    join_team_command = JoinTeam.new(
      register_user_command.user_id,
      the_penguins.team_id
    )
    {:error, _} = Router.dispatch(join_team_command)

    the_noodles = RegisterTeam.new("The Noodles")
    :ok = Router.dispatch(the_noodles)

    game = ScheduleGame.new(
      location: "Monarch Park: Field 1",
      start: Ecto.DateTime.utc,
      home_team_id: the_penguins.team_id,
      away_team_id: the_noodles.team_id
    )

    :ok = Router.dispatch(game)

    # Home team attendance check
    check_attendance = CheckAttendance.new(game.game_id, the_penguins.team_id)
    :ok = Router.dispatch(check_attendance)

    # # Terrible HACK: the projection doesn't have time to run.
    :timer.sleep 100

    bob_ross_id = register_user_command.user_id
    query = from u in UserReadModel,
      where: u.id == ^bob_ross_id,
      select: u

    user = Repo.one(query)
    token = hd(user.attendance_checks)

    confirm_command = ConfirmAttendance.new(token, :in, "I'll be 5 minutes late")
    :ok = Router.dispatch(confirm_command)

    :timer.sleep 100
  end

end
