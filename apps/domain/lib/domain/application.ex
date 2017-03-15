defmodule Attend.Domain.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Attend.Repo, []),
      worker(Commanded.Event.Handler, ["UserProjection", Attend.EventHandlers.UserProjection]),
    ]

    opts = [strategy: :one_for_one, name: Attend.Domain.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
