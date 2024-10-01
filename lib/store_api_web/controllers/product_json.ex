defmodule StoreApiWeb.ProductJSON do
  alias StoreApi.Products.Product

  def list(%{products: products}) do
    %{
      success: true,
      products: for(product <- products, do: data(product))
    }
  end

  def show(%{product: product}) do
    %{success: true, product: data(product)}
  end

  def data(%Product{} = product) do
    %{
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      stock: product.stock,
      inserted_at: product.inserted_at,
      updated_at: product.updated_at
    }
  end
end
