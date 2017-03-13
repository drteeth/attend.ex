defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{RegisterUser, Router}

  test "register user command" do
    command = RegisterUser.register(name: "Ben Moss", email: "drteeth@gmail.com")
    Router.dispatch(command)
  end
end
