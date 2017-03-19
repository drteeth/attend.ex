defmodule Attend.Id do
  def generate do
    Ecto.UUID.generate()
  end
end
