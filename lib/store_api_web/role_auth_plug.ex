defmodule StoreApiWeb.RoleAuthPlug do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _params) do
    user = conn.assigns.current_user

    if user && user.role === "admin" do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> json(%{success: false, message: "You're not allowed to this action"})
      |> halt()
    end
  end
end
