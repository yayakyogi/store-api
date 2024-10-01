defmodule StoreApiWeb.StoreJSON do
  alias StoreApi.Stores.Store

  def show(%{success: success, store: store}) do
    %{success: success, store: data(store)}
  end

  def data(%Store{} = store) do
    %{
      id: store.id,
      name: store.name,
      inserted_at: store.inserted_at,
      updated_at: store.updated_at,
    }
  end
end
