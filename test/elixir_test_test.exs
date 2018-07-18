defmodule ElixirTestTest do
  use ExUnit.Case
  doctest ElixirTest

  test "wrong agrs type" do
    assert  ElixirTest.Wrap.list(nil, nil) == "You must pass 2 lists!"
  end

  test "wrap 2 lists with tests params" do
    one_list = [1,2]
    second_list = ["a", "b", "c"]
    wrapped = ElixirTest.Wrap.list(one_list, second_list)
    assert  wrapped == [[a: 1, b: "a"], [a: 1, b: "b"], [a: 1, b: "c"], [a: 2, b: "a"], [a: 2, b: "b"], [a: 2, b: "c"]]
  end

  test "wrap 2 lists with my params" do
    one_list = [1, 2, 3]
    second_list = ["a", "b", "c", "d"]
    wrapped = ElixirTest.Wrap.list(one_list, second_list)
    assert  wrapped == [[a: 1, b: "a"], [a: 1, b: "b"], [a: 1, b: "c"], [a: 1, b: "d"], [a: 2, b: "a"], [a: 2, b: "b"], [a: 2, b: "c"], [a: 2, b: "d"], [a: 3, b: "a"], [a: 3, b: "b"], [a: 3, b: "c"], [a: 3, b: "d"]]
  end
end
