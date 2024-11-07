defmodule StoreApiWeb.ProductController do
  use StoreApiWeb, :controller

  import Ecto.Query, warn: false
  alias StoreApi.Products
  alias StoreApi.Products.Product
  alias StoreApi.Categories
  alias StoreApi.Stores

  action_fallback StoreApiWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products();
    render(conn, :list, %{products: products})
  end

  def show(conn, %{"id" => id}) do
    try do
      product = Products.get_product!(id)
      render(conn, :show, %{product: product})
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def create(conn, params) do
    category_id = params["category_id"]
    store_id = params["store_id"]

    try do
      Categories.get_category!(category_id)
      Stores.get_store!(store_id)

      with{:ok, %Product{} = product} <- Products.create_product(params) do
        render(conn, :show, %{product: product})
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def update(conn, %{"id" => id, "product" => product}) do
    try do
      get_product = Products.get_product!(id)

      with{:ok, %Product{} = product} <- Products.update_product(get_product, product) do
        render(conn, :show, %{product: product})
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      product = Products.get_product!(id)

      with{:ok, %Product{}} <- Products.delete_product(product) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def upload(conn, %{"file" => uploads}) do
    filename = uploads.filename
    path = uploads.path
    timestamp = DateTime.utc_now() |> DateTime.to_unix(:millisecond);

   if String.ends_with?(filename , [".jpg", ".png"]) do
    upload_dir = "priv/static/uploads"

    File.mkdir_p!(upload_dir)

    file_path = Path.join(upload_dir, filename)

    case File.cp(path, file_path) do
      :ok ->
        json(conn, %{status: "ok", path: file_path})
      {:error, reason} ->
        json(conn ,%{status: "error", reason: reason})
    end
    else
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Only .jpg and .png files are allowed."})
   end
  end
end
