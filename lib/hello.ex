defmodule Hello do
  @moduledoc """
  Hello keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def start_producer(arg \\ nil) do
    with {:ok, pid} <- DynamicSupervisor.start_child(Hello.DynamicSupervisor, {Hello.GenStage.Producer, arg}),
        _ <- DynamicSupervisor.start_child(Hello.DynamicSupervisor, {Hello.GenStage.Consumer, arg}) do
      {:ok, pid}
    else
      {:error, {:already_started, pid}} -> {:ok, pid}
      _ -> {:error, :failed_to_start}
    end
  end
end
