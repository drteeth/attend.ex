defmodule Attend.RegisterUser do
  defstruct [:id, :name, :email]

  def register(name: name, email: email) do
    # TODO handle :email_already_registered
    %__MODULE__{
      id: Attend.Id.generate,
      name: name,
      email: email
    }
  end
end
