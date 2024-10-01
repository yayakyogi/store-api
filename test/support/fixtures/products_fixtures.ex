defmodule StoreApi.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StoreApi.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: 120.5,
        stock: 120.5
      })
      |> StoreApi.Products.create_product()

    product
  end
end
