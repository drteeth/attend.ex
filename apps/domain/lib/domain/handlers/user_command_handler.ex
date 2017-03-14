defmodule Attend.UserCommandHandler do
  @behaviour Commanded.Commands.Handler

  alias Attend.{User, RegisterUser}

  def handle(%User{} = user, %RegisterUser{id: id, name: name, email: email}) do
    user |> User.register(id, name, email)
  end

end
