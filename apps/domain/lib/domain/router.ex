defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{RegisterUser, User}

  dispatch RegisterUser, to: User, identity: :id
end
