defmodule Attend.EventHandlers.UserProjection do
  @behaviour Commanded.Event.Handler

  def start_link do
    {:ok, 123}
  end

  def handle(%Attend.UserRegistered{
        user_id: _id,
        name: name,
        email: email}, _metadata) do
    IO.inspect name
    :ok
  end

  def handle(_event, _metadata) do
    # IO.inspect event
    # IO.inspect metadata
    :ok
  end

end
