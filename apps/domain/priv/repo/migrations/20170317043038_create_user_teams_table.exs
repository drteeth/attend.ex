defmodule Attend.Repo.Migrations.CreateUserTeamsTable do
  use Ecto.Migration

  def change do
    create table(:user_teams, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string
      add :teams, {:array, :map}
    end
  end

end
