defmodule Hello.GenStage.Consumer do
  @max_demand 20 # 最大並列数
  @min_demand 5

  def get_max_demand do
    @max_demand
  end

  use ConsumerSupervisor

  def start_link(_) do
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      %{
        id: Hello.GenStage.Worker,
        start: {Hello.GenStage.Worker, :start_link, []},
        restart: :temporary,
        type: :worker
      }
    ]

    {:ok, children, strategy: :one_for_one, subscribe_to: [
      {Hello.GenStage.Producer, max_demand: @max_demand, min_demand: @min_demand}
    ]}
  end
end
