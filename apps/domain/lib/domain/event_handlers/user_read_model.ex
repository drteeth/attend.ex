defmodule Attend.UserReadModel do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "users" do
    field :name, :string
    field :email, :string

    timestamps()
  end
end
