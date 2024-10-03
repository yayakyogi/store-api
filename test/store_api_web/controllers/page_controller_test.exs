defmodule StoreApiWeb.PageControllerTest do
  use StoreApiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert %{"api" => "Store API"} == json_response(conn, 200)
  end
end
