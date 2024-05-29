defmodule ByteExchangeWeb.HomeLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.{Threads, Posts}

  import ByteExchangeWeb.{PostLive.Component, ThreadLive.Component}

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="flex flex-col w-full">
        <.post :for={{post_id, post} <- @streams.posts} id={post_id} post={post} />
      </div>
      <div class="
        m-8 h-[100vh] w-[23rem] mr-3 justify-end relative hidden
        lg:block p-4 rounded-md shadow-2xl">
        <.link
          navigate={~p"/discovery"}
          class="text-center flex justify-center m-5 bg-slate-950 py-2 rounded-md"
        >
          Discover All
        </.link>
        <div class="w-full bg-slate-700 h-[0.1rem] mb-2"></div>
        <div>
          <h3 class="font-bold mb-4">
            <.icon name="hero-bookmark" /> Subscribed Threads
          </h3>
          <.thread
            :for={{thread_id, thread} <- @streams.threads}
            class="bg-slate-800 p-2 rounded-md"
            id={thread_id}
            thread={thread}
          />
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream(:threads, Threads.list_threads())
      |> stream(:posts, Enum.reverse(Posts.list_posts()))

    {:ok, socket}
  end
end
