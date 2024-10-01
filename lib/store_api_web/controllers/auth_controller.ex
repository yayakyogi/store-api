defmodule StoreApiWeb.AuthController do
  use StoreApiWeb, :controller

  alias StoreApi.Accounts
  alias StoreApi.Accounts.User
  alias StoreApiWeb.JWTToken

  action_fallback StoreApiWeb.FallbackController

  def ping(conn, _params) do
    render(conn, :message, %{success: true, message: "Connected"})
  end

  def register(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params) do
      conn
      |> put_status(:created)
      |> render(:show, %{success: true, user: user})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    with %User{} = user <- Accounts.get_user_by_email(email), true <- Pbkdf2.verify_pass(password, user.password) do
       secret = "z2YhWroSFlX29UhOBiRxfr1LOtKjIQ1EOYIZFDz0+1U38oDdZGZdnxZ9HW4sE77w"
       signer = Joken.Signer.create("HS256", secret)
       extra_claims = %{user_id: user.id}

       {:ok, token, _claims} = JWTToken.generate_and_sign(extra_claims, signer)

       conn
       |> put_status(200)
       |> render(:loginResponse, %{success: true, token: token})
    else
      nil -> {:error, :not_found}
      false -> {:error, :unauthorized}
    end
  end

  def get(conn, _params) do
    conn
    |> json(%{user: conn.assigns.current_user.role})
  end
end
