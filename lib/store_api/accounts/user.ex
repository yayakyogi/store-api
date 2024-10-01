defmodule StoreApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoreApi.Stores.Store

  schema "users" do
    field :name, :string
    field :password, :string
    field :role, :string
    field :email, :string

    has_one :stores, Store

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :role])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> update_change(:username, &String.downcase(&1))
    |> validate_length(:password, min: 2, message: "Should be at least 2 caracters")
    |> validate_length(:password, max: 20, message: "Can't be more than 20 caracters")
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} -> put_change(changeset, :password, Pbkdf2.hash_pwd_salt(password))
      _ -> changeset
    end
  end
end
