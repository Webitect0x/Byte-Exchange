defmodule ByteExchangeWeb.DiscoveryLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.Threads
  alias ByteExchangeWeb.ThreadLive.ThreadForm
  import ByteExchangeWeb.ThreadLive.Component

  def render(assigns) do
    ~H"""
    <div>
      <div class="flex justify-between p-6">
        <h2 class="text-2xl font-bold">Discovery</h2>

        <div
          :if={@current_user}
          class="flex items-center gap-2 border border-slate-800 px-2 py-1 rounded-md"
        >
          <.link class="text-md" patch={~p"/discovery/new"}>Create A New Thread</.link>
          <.icon name="hero-plus-circle" />
        </div>
      </div>
      <div class="bg-slate-800 h-[0.1rem] mx-4"></div>
      <.modal
        :if={@live_action in [:new]}
        show
        on_cancel={JS.navigate(~p"/discovery")}
        id="transaction-form"
      >
        <.live_component module={ThreadForm} current_user={@current_user} id="discovery-form" />
      </.modal>

      <.thread
        :for={{thread_id, thread} <- @streams.threads}
        class="bg-slate-800 w-[15rem] p-3 rounded-lg"
        id={thread_id}
        thread={thread}
      />
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, stream(socket, :threads, Threads.list_threads())}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end
end
