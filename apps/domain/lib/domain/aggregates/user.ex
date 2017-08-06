defmodule Attend.User do
  alias Attend.{User, User.Register}

  defstruct [:id, :name, :email]

  # Commands
  defmodule Register, do: defstruct [:user_id, :name, :email]

  # Events
  defmodule Registered, do: defstruct [:user_id, :name, :email]

  # handlers
  def execute(%User{id: nil} = _, %Register{} = command) do
    %Registered{
      user_id: command.user_id,
      name: command.name,
      email: command.email
    }
  end
  def execute(%User{} = _user, %Register{} = _command) do
    {:error, :already_registered}
  end

  def apply(%User{} = user, %Registered{} = event) do
    %User{user | id: event.user_id, name: event.name, email: event.email}
  end

end
