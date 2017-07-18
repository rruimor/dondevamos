defmodule Dondevamos.EnumHelper do

  import Enum, only: [ reduce: 2 ]

  @doc """
  Calculate the intersections of multiple 1-level deep lists
  """
  def intersections(lists) do
    lists
    |> reduce(fn(x, acc) -> acc -- (acc -- x) end)
  end

end
