defmodule StoreApiWeb.StoreController do
  use StoreApiWeb, :controller

  import Ecto.Query, warn: false
  alias StoreApi.Stores.Store
  alias StoreApi.Stores
  alias StoreApi.Repo

  action_fallback StoreApiWeb.FallbackController

  def get(conn, _params) do
    conn
    |> json(%{success: true, message: "Admin role"})
  end

  def create(conn, params) do
    user_id = conn.assigns.current_user.id;
    store = Stores.get_store_by_userid(user_id)

    # check if user already created store or not
    if store == nil do
      res = Ecto.build_assoc(conn.assigns.current_user, :stores) |> Store.changeset(params)

      with changeset <- res , {:ok, %Store{} = store} <- Repo.insert(changeset) do
        render(conn, :show, %{success: true, store: store})
      else
        {:error, changeset} -> {:error, changeset}
      end
    else
      conn |> json(%{success: false, message: "You already have a registered shop"})
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      store = Stores.get_store!(id)
      render(conn, :show, %{success: true, store: store})
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def update(conn, %{"id" => id, "name" => name}) do
    try do
      store = Stores.get_store!(id)

      with {:ok, %Store{} = store} <- Stores.update_store(store, %{name: name}) do
        render(conn, :show, %{success: true, store: store})
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      store = Stores.get_store!(id)

      with {:ok, %Store{}} <- Stores.delete_store(store) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> {:error, :not_found}
    end
  end
end
