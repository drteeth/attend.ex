defmodule Attend.User do
  defstruct [:id, :name, :email]

  alias Attend.User

  defmodule UserRegistered, do: defstruct [
        user_id: nil,
        name: nil,
        email: nil
      ]

  def register(%User{id: nil} = _user, id, name, email) do
    %UserRegistered{user_id: id, name: name, email: email}
  end

  def register(%User{}, _, _, _) do
    {:error, :already_registered}
  end

  def apply(%User{} = user, %UserRegistered{user_id: id, name: name, email: email}) do
    %User{user | id: id, name: name, email: email}
  end

end
