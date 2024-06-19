defmodule Hello.GenStage.Producer do
  @max_demand Hello.GenStage.Consumer.get_max_demand()

  use GenStage

  def start_link(_) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer, {:queue.new, 0}, dispatcher: GenStage.DemandDispatcher}
  end

  def handle_cast({:message, event}, {queue, demand}) do
    dispatch_events([], {:queue.in({nil, event}, queue), demand})
  end

  def handle_call({:message, event}, from, {queue, demand}) do
    dispatch_events([], {:queue.in({from, event}, queue), demand})
  end

  defp dispatch_events(events, {queue, demand}) do
    with d when d > 0 <- demand,
         {{:value, {from, event}}, queue} <- :queue.out(queue) do
      if from != nil do
        GenStage.reply(from, :ok)
      end
      dispatch_events([event | events], {queue, demand - 1})
    else
      _ ->
        {:noreply, Enum.reverse(events), {queue, demand}}
    end
  end

  # まず最初にConsumerからの要求を受け、demandに値をセットする
  def handle_demand(incoming_demand, {queue, demand}) do
    IO.puts("(handle_demand) incoming_demand: #{inspect(incoming_demand)}")
    new_demand = min(incoming_demand + demand, @max_demand)
    dispatch_events([], {queue, new_demand})
  end
end
