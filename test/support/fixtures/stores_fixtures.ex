defmodule StoreApi.StoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StoreApi.Stores` context.
  """

  @doc """
  Generate a store.
  """
  def store_fixture(attrs \\ %{}) do
    {:ok, store} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> StoreApi.Stores.create_store()

    store
  end
end
