defmodule StoreApiWeb.ProductJSON do
  alias StoreApi.Products.Product

  def list(%{products: products}) do
    %{
      success: true,
      products: for(product <- products, do: data_list(product))
    }
  end

  def show(%{product: product}) do
    %{
      success: true,
      product:  %{
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        stock: product.stock,
        inserted_at: product.inserted_at,
        updated_at: product.updated_at,
      }
    }
  end

  def data_list(%Product{} = product) do
    %{
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      stock: product.stock,
      inserted_at: product.inserted_at,
      updated_at: product.updated_at,
      store: %{
        id: product.store.id,
        name: product.store.name
      },
      category: %{
        id: product.category.id,
        name: product.category.name
      }
    }
  end
end
