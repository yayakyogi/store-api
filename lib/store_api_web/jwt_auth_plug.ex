defmodule StoreApiWeb.JWTAuthPlug do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]

  alias StoreApi.Accounts
  alias StoreApi.Accounts.User
  alias StoreApiWeb.JWTToken

  def init(opts), do: opts

  def call(conn, _) do
    bearer = get_req_header(conn, "authorization") |> List.first()

    if bearer == nil do
      conn
      |> put_status(:unauthorized)
      |> json(%{success: false, message: "Unauthorized"})
      |> halt
    else
      token = bearer |> String.split(" ") |> List.last()
      secret = "z2YhWroSFlX29UhOBiRxfr1LOtKjIQ1EOYIZFDz0+1U38oDdZGZdnxZ9HW4sE77w"
      signer = Joken.Signer.create("HS256", secret)

      with {:ok, %{"user_id" => user_id}} <-
        JWTToken.verify_and_validate(token, signer),
        %User{} = user <- Accounts.get_user(user_id) do

        conn |> assign(:current_user, user)
      else
        {:error, reasons} ->
          conn
          |> put_status(401)
          |> json(%{success: false, message: Keyword.get(reasons, :message)})
          |> halt()
       nil ->
          conn
          |> put_status(:not_found)
          |> json(%{success: false, message: "Resource not found"})
          |> halt()
      end
    end
  end
end
