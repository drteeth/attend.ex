defmodule Attend.RosterHandler do
  @behaviour Commanded.Event.Handler

  alias Attend.{TeamRegistered, PlayerJoinedTeam}

  def handle(%TeamRegistered{team_id: team_id, name: name}, _metadata) do
  end

  def handle(%PlayerJoinedTeam{team_id: team_id, user_id: user_id}, _metadata) do
  end

  def handle(_event, _metadata), do: :ok
end
