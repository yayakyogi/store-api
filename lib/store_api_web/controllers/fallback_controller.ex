defmodule StoreApiWeb.FallbackController do
  use StoreApiWeb, :controller

   # This clause is an example of how to handle resources that cannot be found.
   def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: StoreApiWeb.ErrorHTML, json: StoreApiWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(html: StoreApiWeb.ErrorHTML, json: StoreApiWeb.ErrorJSON)
    |> render(:"401")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    errors = format_errors(changeset.errors)

    conn
    |> put_status(:unprocessable_entity)
    |> json(%{success: false, errors: errors})
  end

  defp format_errors(errors) do
    Enum.into(errors, %{}, fn {field, {message, _}} ->
      {field, message}
    end)
  end
end
