defmodule SbResultTest do
  use ExUnit.Case
  doctest SbResult
  import SbResult

  test "greets the world" do
      a = {:ok,2}
      >>> fn b -> 2*b end.()
      assert a == 4

      b = {:ok,2}
      >>> (map fn b -> 2*b end.())
      >>> fn c -> 2*c end.()
      assert b == 8

  end
end
