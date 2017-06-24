defmodule Attend.UserReadModel do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "users" do
    field :name, :string
    field :email, :string
    field :attendance_checks, {:array, :string}, default: []

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email, :attendance_checks])
  end
end
