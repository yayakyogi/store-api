defmodule StoreApiWeb.ErrorJSONTest do
  use StoreApiWeb.ConnCase, async: true

  test "renders 404" do
    assert StoreApiWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{message: "Resource Not Found"},success: false}
  end

  test "renders 500" do
    assert StoreApiWeb.ErrorJSON.render("500.json", %{}) == %{errors: %{detail: "Internal Server Error"}}
  end
end
