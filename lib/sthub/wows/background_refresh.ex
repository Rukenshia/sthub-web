defmodule StHub.Wows.BackgroundRefresh do
  use GenServer
  require Logger

  alias StHub.Wows

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send(self(), :work, [:noconnect])
    {:ok, state}
  end

  def handle_info(:work, state) do
    do_work(state)
  end

  def do_work(state) do
    Logger.info("StHub.WowsBackgroundRefresh.do_work")

    :ok = Wows.update_ship_database()

    # Reschedule
    Logger.info("StHub.WowsBackgroundRefresh.do_work.done")
    schedule()
    {:noreply, state}
  end

  defp schedule() do
    # Every 6 hours
    Process.send_after(self(), :work, 6 * 60 * 60 * 1000)
  end
end
