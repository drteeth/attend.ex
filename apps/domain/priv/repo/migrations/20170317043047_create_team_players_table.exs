defmodule Attend.Repo.Migrations.CreateTeamPlayersTable do
  use Ecto.Migration

  def change do
    create table(:team_players, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :players, {:array, :map}
    end
  end
end
