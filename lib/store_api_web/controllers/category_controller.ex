defmodule StoreApiWeb.CategoryController do
  use StoreApiWeb, :controller

  import Ecto.Query, warn: false
  alias StoreApi.Categories
  alias StoreApi.Categories.Category

  action_fallback StoreApiWeb.FallbackController

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, :list, %{categories: categories})
  end

  def show(conn, %{"id" => id}) do
    try do
      category = Categories.get_category!(id)
      render(conn, :show, %{category: category})
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def create(conn, params) do
    with {:ok, %Category{} = category} <- Categories.create_category(params) do
      render(conn, :show, %{category: category})
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      category = Categories.get_category!(id)

      with{:ok, %Category{}} <- Categories.delete_category(category) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end
end
