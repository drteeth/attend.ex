defmodule Attend.UserTest do
  use ExUnit.Case

  alias Attend.{User, RegisterUser, Router}

  test "register user command" do
    command = RegisterUser.register(name: "Ben Moss", email: "drteeth@gmail.com")
    Router.dispatch(command)

    {:ok, events} = EventStore.read_stream_forward(command.id)
    IO.inspect List.foldl(events, %User{}, fn (event, user) ->
      User.apply(user, event.data)
    end)
    IO.inspect(events)
  end
end
