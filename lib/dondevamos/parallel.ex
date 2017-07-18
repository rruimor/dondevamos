defmodule Dondevamos.Parallel do
  def pmap(collection, fun) do
    me = self() # keep track of the parent process
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, { self(), fun.(elem) }) end # self() refers to the spawned new process
    end)
    |> Enum.map(fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end
end
