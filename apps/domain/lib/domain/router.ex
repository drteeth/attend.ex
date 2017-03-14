defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{
    RegisterUser, User, UserCommandHandler,
    RegisterTeam, Team, TeamCommandHandler
  }

  dispatch RegisterUser, to: UserCommandHandler,
    aggregate: User, identity: :id

  dispatch RegisterTeam, to: TeamCommandHandler,
    aggregate: Team, identity: :id

end
