defmodule Attend.RegisterTeam do
  defstruct [:id, :name]

  def register(name: name) do
    %__MODULE__{
      id: Attend.Id.generate(),
      name: name
    }
  end
end
