defmodule Attend.RegisterTeam do
  defstruct [:id, :name]

  alias Attend.RegisterTeam

  def register(name: name) do
    %RegisterTeam{id: Attend.Id.generate(), name: name}
  end
end
