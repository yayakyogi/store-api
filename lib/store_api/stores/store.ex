defmodule StoreApi.Stores.Store do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoreApi.Accounts.User
  alias StoreApi.Products.Product

  schema "stores" do
    field :name, :string

    has_many :products, Product
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stores, attrs) do
    stores
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
