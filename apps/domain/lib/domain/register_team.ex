defmodule Attend.RegisterTeam do
  defstruct [:id, :name]

  def register(name: name) do
    %__MODULE__{
      id: Ecto.UUID.generate,
      name: name
    }
  end
end
