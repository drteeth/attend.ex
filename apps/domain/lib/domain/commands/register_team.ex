defmodule Attend.RegisterTeam do
  defstruct [:team_id, :name]

  alias Attend.RegisterTeam

  def register(name: name) do
    %RegisterTeam{team_id: Attend.Id.generate(), name: name}
  end
end
