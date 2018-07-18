defmodule GitHubTest do
  use ExUnit.Case
  doctest ElixirTest

  test "return public repo starts" do
    # Count can be changed
    assert GitHub.starts("rails/rails") == {:ok, 40212}
  end

  test "returns error when repo is private" do
    assert GitHub.starts("Bongoresearch/reagent") == {:error, "repo is private or missing"}
  end

  test "returns error when repo is missing" do
    assert GitHub.starts("Bongoresearch/reagent2222") == {:error, "repo is private or missing"}
  end
end
