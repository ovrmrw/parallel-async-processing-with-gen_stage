defmodule Hello.Test do
  @timeout 60000

  def run(type) do
    produce(type)
  end

  def produce(type) do
    {:ok, producer} = Hello.start_producer()

    produce_events = fn range ->
      range
      |> Enum.each(fn i -> async_square_root(type, producer, i) end)
    end

    produce_events.(1..100)
  end

  defp async_square_root(type, pid, i) do
    case type do
      :call ->
        GenStage.call(pid, {:message, i}, @timeout)
        IO.puts("called #{i}")
      :cast ->
        GenStage.cast(pid, {:message, i})
        IO.puts("casted #{i}")
    end
  end
end
