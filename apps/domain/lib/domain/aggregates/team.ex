defmodule Attend.Team do
  defstruct [:id, :name, :players]

  alias Attend.{
    Team,
    RegisterTeam,
    JoinTeam,
    Id,
  }

  defmodule RegisterTeam do
    defstruct [:team_id, :name]

    def new(name) do
      %RegisterTeam{team_id: Id.generate(), name: name}
    end
  end

  defmodule JoinTeam do
    defstruct [:user_id, :team_id]

    def new(user_id, team_id) do
      %JoinTeam{user_id: user_id, team_id: team_id}
    end
  end

  defmodule TeamRegistered, do: defstruct [:team_id, :name]
  defmodule PlayerJoinedTeam, do: defstruct [:team_id, :user_id]

  def execute(%Team{} = _team, %RegisterTeam{} = command) do
    %TeamRegistered{team_id: command.team_id, name: command.name}
  end

  def execute(%Team{} = team, %JoinTeam{} = command) do
    # TODO Validate that the team exists?

    if Enum.member?(team.players, command.user_id) do
      {:error, :player_already_joined_team}
    else
      %PlayerJoinedTeam{user_id: command.user_id, team_id: command.team_id}
    end
  end

  def apply(%Team{} = team, %TeamRegistered{team_id: id, name: name}) do
    %Team{team | id: id, name: name, players: []}
  end

  def apply(%Team{id: id} = team, %PlayerJoinedTeam{team_id: id, user_id: user_id}) do
    %Team{team | players: [user_id | team.players]}
  end
end
