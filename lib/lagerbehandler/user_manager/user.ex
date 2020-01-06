defmodule Lagerbehandler.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string
    field :username, :string
    field :admin, :boolean
    field :departments, :string

    timestamps()
  end

  @departments ["admin"]

  alias Argon2

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :admin, :departments])
    |> validate_required([:username, :password])
    |> validate_department(:departments)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

  def validate_department(changeset, field, options \\ []) do
    validate_change(changeset, field, fn :departments, department ->
      if Enum.member?(@departments, department) do
        []
      else
        [departments: "invalaid department"]
      end
    end)
  end
end
