defmodule StoreApiWeb.CategoryJSON do
  alias StoreApi.Categories.Category

  def list(%{categories: categories}) do
    %{
        success: true,
        categories: for(category <- categories, do: data(category))
    }
  end

  def show(%{category: category}) do
    %{
        success: true,
        category: data(category)
    }
  end

  def data(%Category{} = category) do
    %{
      id: category.id,
      name: category.name,
      inserted_at: category.inserted_at,
      updated_at: category.updated_at
    }
  end
end
