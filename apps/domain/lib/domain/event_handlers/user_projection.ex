defmodule Attend.EventHandlers.UserProjection do
  @behaviour Commanded.Event.Handler

  alias Attend.{
    User.UserRegistered,
    UserReadModel,
    Repo,
  }

  def handle(%UserRegistered{user_id: id, name: name, email: email}, _metadata) do
    case Repo.insert(%UserReadModel{id: id, name: name, email: email}) do
      {:ok, _} -> :ok
      e -> e
    end
  end

  def handle(_event, _metadata), do: :ok

end
