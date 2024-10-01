defmodule StoreApi.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoreApi.Stores.Store
  alias StoreApi.Categories.Category

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :float
    field :stock, :float

    belongs_to :store, Store
    belongs_to :category, Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :stock, :store_id, :category_id])
    |> validate_required([:name, :description, :price, :stock, :store_id, :category_id])
  end
end
