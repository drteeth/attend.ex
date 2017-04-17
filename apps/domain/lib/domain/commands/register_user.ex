defmodule Attend.RegisterUser do
  defstruct [:id, :name, :email]

  alias Attend.RegisterUser

  def register(name: name, email: email) do
    # TODO handle :email_already_registered
    %RegisterUser{
      id: Attend.Id.generate(),
      name: name,
      email: email
    }
  end
end
