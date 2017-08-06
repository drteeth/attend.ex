defmodule Attend.EventHandlers.TeamProjection do
  @behaviour Commanded.Event.Handler

  alias Attend.{User, Team, Repo}

  defmodule UserTeams do
    use Ecto.Schema

    @primary_key {:id, :binary_id, autogenerate: false}
    schema "user_teams" do
      field :name, :string
      field :email, :string
      field :teams, {:array, :map}
    end
  end

  defmodule TeamPlayers do
    use Ecto.Schema

    @primary_key {:id, :binary_id, autogenerate: false}
    schema "team_players" do
      field :name, :string
      field :players, {:array, :map}
    end
  end

  def handle(%User.Registered{user_id: user_id, name: name, email: email}, _metadata) do
    Repo.insert!(%UserTeams{id: user_id, name: name, email: email, teams: []})
    :ok
  end

  def handle(%Team.Registered{team_id: team_id, name: name}, _metadata) do
    Repo.insert!(%TeamPlayers{id: team_id, name: name, players: []})
    :ok
  end

  def handle(%Team.PlayerJoined{team_id: team_id, user_id: user_id}, _metadata) do
    Repo.transaction fn ->
      # find the player and the team
      player = Repo.get!(UserTeams, user_id)
      team = Repo.get!(TeamPlayers, team_id)

      # update the player's team with the new team
      team_attrs = %{id: team.id, name: team.name}
      player
      |> Ecto.Changeset.change(teams: [team_attrs | player.teams])
      |> Repo.update!

      # update the team's roster with the new player
      player_attrs = %{id: player.id, name: player.name, email: player.email}
      team
      |> Ecto.Changeset.change(players: [player_attrs | team.players])
      |> Repo.update!
    end
    :ok
  end

  def handle(_event, _metadata), do: :ok

end
