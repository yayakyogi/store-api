defmodule StoreApi.Stores do
  @moduledoc """
  The Stores context.
  """

  import Ecto.Query, warn: false
  alias StoreApi.Repo

  alias StoreApi.Stores.Store

  @doc """
  Returns the list of store.

  ## Examples

      iex> list_store()
      [%Store{}, ...]

  """
  def list_store do
    Repo.all(Store)
  end

  @doc """
  Gets a single store.

  Raises `Ecto.NoResultsError` if the Store does not exist.

  ## Examples

      iex> get_store!(123)
      %Store{}

      iex> get_store!(456)
      ** (Ecto.NoResultsError)

  """
  def get_store!(id), do: Repo.get!(Store, id)
  def get_store_by_userid(userid) do
    from(
      s in Store,
      where: s.user_id == ^userid,
      select: [:id]
    )
    |> Repo.one()
  end
  @doc """
  Creates a store.

  ## Examples

      iex> create_store(%{field: value})
      {:ok, %Store{}}

      iex> create_store(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_store(attrs \\ %{}) do
    %Store{}
    |> Store.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a store.

  ## Examples

      iex> update_store(store, %{field: new_value})
      {:ok, %Store{}}

      iex> update_store(store, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_store(%Store{} = store, attrs) do
    store
    |> Store.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a store.

  ## Examples

      iex> delete_store(store)
      {:ok, %Store{}}

      iex> delete_store(store)
      {:error, %Ecto.Changeset{}}

  """
  def delete_store(%Store{} = store) do
    Repo.delete(store)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking store changes.

  ## Examples

      iex> change_store(store)
      %Ecto.Changeset{data: %Store{}}

  """
  def change_store(%Store{} = store, attrs \\ %{}) do
    Store.changeset(store, attrs)
  end
end
