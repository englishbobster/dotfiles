defmodule Multiples do

  def multiples_3_5(finish) do
    0..(finish - 1)
    |> Enum.filter(fn x -> rem(x,3) == 0 end)
    |> Enum.filter(fn x -> rem(x,5) == 0 end)
    |> Enum.sum
  end

  def display_result(finish) do
    result = multiples_3_5(finish)
    IO.puts("Result for #{finish}: #{result}")
  end

end

Multiples.display_result(10)
Multiples.display_result(1000)
