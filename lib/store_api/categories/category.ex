defmodule StoreApi.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoreApi.Products.Product

  schema "categories" do
    field :name, :string

    has_many :products, Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
