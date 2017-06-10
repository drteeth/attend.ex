defmodule Attend.Domain.Application do
  @moduledoc false

  use Application

  alias Attend.{
    Repo,
    EventHandlers.TeamGames,
    EventHandlers.UserProjection,
    EventHandlers.TeamProjection,
    AttendanceChecker,
  }

  alias Commanded.Event.Handler
  alias Commanded.ProcessManagers.ProcessRouter

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Repo, []),
      worker(TeamGames, []),
      worker(ProcessRouter, ["AttendanceChecker", AttendanceChecker, Attend.Router, [start_from: :current]],
        id: :attendance_checker),
      worker(Handler, ["UserProjection", UserProjection], id: :user_projection),
      worker(Handler, ["TeamProjection", TeamProjection], id: :team_projection),
      worker(Handler, ["GameProjection", TeamGames], id: :game_projection),
    ]

    opts = [strategy: :one_for_one, name: Attend.Domain.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
