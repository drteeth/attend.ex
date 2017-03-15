defmodule Attend.EventHandlers.UserProjection do
  @behaviour Commanded.Event.Handler

  defmodule User do
    use Ecto.Schema

    @primary_key {:id, :binary_id, autogenerate: false}
    schema "users" do
      field :name, :string
      field :email, :string

      timestamps()
    end
  end

  # defmodule Attend.RosterHandler do
  #   @behaviour Commanded.Event.Handler

  #   def start_link do
  #   end

  #   def handle(UserRegistered{id: id, name: name}, _metadata) do
  #   end

  #   def handle(%TeamRegistered{id: id, name: name}, _metadata) do
  #   end

  #   def handle(PlayerJoinedTeam{team_id: team_id, user_id: user_id}, _metadata) do
  #   end

  #   def handle(_event, _metadata), do: :ok
  # end

  alias Attend.Repo

  def start_link do
    {:ok, 123}
  end

  def handle(%Attend.UserRegistered{
        user_id: id,
        name: name,
        email: email}, _metadata) do
    IO.inspect name
    IO.inspect Repo.insert(%User{
          id: id,
          name: name,
          email: email
                           })
    :ok
  end

  def handle(_event, _metadata) do
    # IO.inspect event
    # IO.inspect metadata
    :ok
  end

end
