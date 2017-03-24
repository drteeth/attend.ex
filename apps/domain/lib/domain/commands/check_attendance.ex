defmodule Attend.CheckAttendance do
  defstruct [:game_id]

  def create(game_id) do
    %__MODULE__{game_id: game_id}
  end

end
