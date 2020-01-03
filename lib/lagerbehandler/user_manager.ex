defmodule Lagerbehandler.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false
  alias Lagerbehandler.Repo

  alias Lagerbehandler.UserManager.User

  alias Argon2
  import Ecto.Query, only: [from: 2]

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Lagerbehandler.PubSub, @topic)
  end

  def subscribe(user_id) do
    Phoenix.PubSub.subscribe(Lagerbehandler.PubSub, @topic <> "#{user_id}")
  end

  def authenticate_user(username, plain_text_password) do
    query = from u in User, where: u.username == ^username

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      ** (Ecto.NoResultsError)

  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:user, :created])
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:user, :updated])
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
    |> notify_subscribers([:user, :deleted])
  end

  def change_user(user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Lagerbehandler.PubSub, @topic, {__MODULE__, event, result})

    Phoenix.PubSub.broadcast(
      Lagerbehandler.PubSub,
      @topic <> "#{result.id}",
      {__MODULE__, event, result}
    )

    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
