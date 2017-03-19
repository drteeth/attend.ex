defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{
    RegisterUser, User, UserCommandHandler,
    RegisterTeam, Team, TeamCommandHandler, JoinTeam,
    ScheduleGame, Game, GameCommandHandler,
  }

  dispatch RegisterUser, to: UserCommandHandler,
    aggregate: User, identity: :id

  dispatch RegisterTeam, to: TeamCommandHandler,
    aggregate: Team, identity: :id

  dispatch JoinTeam, to: TeamCommandHandler,
    aggregate: Team, identity: :team_id

  dispatch ScheduleGame, to: GameCommandHandler,
    aggregate: Game, identity: :game_id

end
