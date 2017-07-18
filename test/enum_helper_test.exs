defmodule EnumHelperTest do
  use ExUnit.Case
  doctest Dondevamos.EnumHelper

  alias Dondevamos.EnumHelper, as: EH

  test ".intersections" do
    lists = [ [1, 2], [2, 3, 5], [2, "a", 25] ]
    assert EH.intersections(lists) == [2]
  end
end
