defmodule Attend.User do
  defstruct [:id, :name, :email]

  alias Attend.{User, RegisterUser}

  defmodule UserRegistered do
    defstruct [:user_id, :name, :email]
  end

  def execute(%User{id: nil} = _, %RegisterUser{} = command) do
    %UserRegistered{user_id: command.user_id, name: command.name, email: command.email}
  end
  def execute(%User{} = _user, %RegisterUser{} = _command) do
    {:error, :already_registered}
  end

  def apply(%User{} = user, %UserRegistered{user_id: id, name: name, email: email}) do
    %User{user | id: id, name: name, email: email}
  end

end
