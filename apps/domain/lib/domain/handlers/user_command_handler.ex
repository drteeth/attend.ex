defmodule Attend.UserCommandHandler do
  @behaviour Commanded.Commands.Handler

  alias Attend.{User, RegisterUser}

  def handle(%User{} = _user, %RegisterUser{id: id, name: name, email: email}) do
    User.register(id, name, email)
  end

end
