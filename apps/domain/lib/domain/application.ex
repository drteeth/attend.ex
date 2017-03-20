defmodule Attend.Domain.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Attend.Repo, []),
      worker(Attend.EventHandlers.TeamGames, []),
      worker(Commanded.Event.Handler, ["UserProjection", Attend.EventHandlers.UserProjection], id: :user_projection),
      worker(Commanded.Event.Handler, ["TeamProjection", Attend.EventHandlers.TeamProjection], id: :team_projection),
      worker(Commanded.Event.Handler, ["GameProjection", Attend.EventHandlers.TeamGames], id: :game_projection),
    ]

    opts = [strategy: :one_for_one, name: Attend.Domain.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
