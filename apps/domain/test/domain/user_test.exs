defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{
    Router,
    RegisterUser,
    RegisterTeam,
  }

  test "register user command" do
    command = RegisterUser.register(name: "Ben Moss", email: "drteeth@gmail.com")
    Router.dispatch(command)
    command = RegisterTeam.register(name: "The Penguins")
    Router.dispatch(command)
  end

end
