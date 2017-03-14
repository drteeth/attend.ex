defmodule Attend.User do
  defstruct [:id, :name, :email]

  alias Attend.{UserRegistered, User}

  def register(id, name, email) do
    %UserRegistered{user_id: id, name: name, email: email}
  end

  def apply(%User{} = user, %UserRegistered{user_id: id, name: name, email: email}) do
    %User{user | id: id, name: name, email: email}
  end

end
