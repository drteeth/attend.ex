defmodule Attend.RegisterUser do
  defstruct [:id, :name, :email]

  def register(name: name, email: email) do
    %__MODULE__{
      id: Ecto.UUID.generate,
      name: name,
      email: email
    }
  end
end
