defmodule StoreApiWeb.AuthJSON do
  alias StoreApi.Accounts.User
  @doc """
    Check API
  """
  def message(%{success: success, message: message}) do
    %{success: success, message: message}
  end

  @doc """
    Renders response login.
  """
  def loginResponse(%{success: success, token: token}) do
    %{success: success, token: token}
  end

  @doc """
    Renders a single user.
  """
  def show(%{success: success, user: user}) do
    %{success: success, user: data(user)}
  end

  def data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      role: user.role,
    }
  end
end
