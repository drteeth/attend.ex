defmodule Attend.User do
  defstruct [:id, :name, :email]

  alias Attend.{User, RegisterUser, Id}

  defmodule RegisterUser do
    defstruct [:user_id, :name, :email]

    def new(name, email) do
      # TODO handle :email_already_registered
      %RegisterUser{
        user_id: Id.generate(),
        name: name,
        email: email
      }
    end
  end

  defmodule UserRegistered do
    defstruct [:user_id, :name, :email]
  end

  def execute(%User{id: nil} = _, %RegisterUser{} = command) do
    %UserRegistered{user_id: command.user_id, name: command.name, email: command.email}
  end
  def execute(%User{} = _user, %RegisterUser{} = _command) do
    {:error, :already_registered}
  end

  def apply(%User{} = user, %UserRegistered{} = event) do
    %User{user | id: event.user_id, name: event.name, email: event.email}
  end

end
