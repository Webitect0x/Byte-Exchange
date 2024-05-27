defmodule ByteExchangeWeb.DiscoveryLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.Threads
  import ByteExchangeWeb.ThreadLive.Component

  def mount(_params, _session, socket) do
    {:ok, stream(socket, :threads, Threads.list_threads())}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h2>Discover</h2>
      <.thread
        :for={{thread_id, thread} <- @streams.threads}
        class="bg-slate-800 w-[15rem] p-3 rounded-lg"
        id={thread_id}
        thread={thread}
      />
    </div>
    """
  end
end
