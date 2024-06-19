defmodule Hello.GenStage.Worker do
  def start_link(event) do
    Task.start_link(fn ->
      IO.puts("process #{inspect(self())} calculating square root of #{event}")
      Process.sleep(1000)
      IO.puts("sqrt #{:math.sqrt(event)} of #{event}")
    end)
  end
end
