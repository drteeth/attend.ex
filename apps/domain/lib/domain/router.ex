defmodule Attend.Router do
  use Commanded.Commands.Router

  alias Attend.{
    RegisterUser, User, UserCommandHandler,
    RegisterTeam, Team, TeamCommandHandler,
    JoinTeam, UserRegistered
  }

  defmodule Roster do
    use Ecto.Schema

    schema "roster" do
      field :team_id
      field :team_name
      field :user_id
      field :user_name
      field :user_email
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


  dispatch RegisterUser, to: UserCommandHandler,
    aggregate: User, identity: :id

  dispatch RegisterTeam, to: TeamCommandHandler,
    aggregate: Team, identity: :id

  dispatch JoinTeam, to: TeamCommandHandler,
    aggregate: Team, identity: :team_id

end
