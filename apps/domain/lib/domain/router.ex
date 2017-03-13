defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{UserCommandHandler, User, RegisterUser}

  dispatch RegisterUser, to: UserCommandHandler, aggregate: User, identity: :id
end
