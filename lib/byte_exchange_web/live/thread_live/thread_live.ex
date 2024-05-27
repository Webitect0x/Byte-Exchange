defmodule ByteExchangeWeb.ThreadLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.{Threads, Posts}

  import ByteExchangeWeb.PostLive.Component

  def mount(%{"thread_title" => thread_title}, _session, socket) do
    thread = Threads.get_thread_by_title!(thread_title)
    posts = Posts.list_posts_by_thread(thread.id)

    IO.inspect(posts)

    socket =
      socket
      |> stream(:posts, posts)
      |> assign(:thread, thread)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="w-full">
        <.post :for={{post_id, post} <- @streams.posts} id={post_id} post={post} />
      </div>
      <div class="bg-slate-900 h-[100vh] mr-3 justify-end relative w-fit hidden lg:block p-4 rounded-md shadow-2xl">
        <h2 class="text-2xl font-bold text-center p-2 w-[15rem]"><%= @thread.title %></h2>
        <div class="text-center text-xs">
          <span><%= @thread.subscribers %> Subscribers</span>
        </div>
        <div class="flex flex-col mt-5 gap-3 justify-center">
          <.button>Subscribe</.button>
          <.button>Chatroom</.button>
          <.link
            class=" rounded-lg bg-slate-950 shadow-xl hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-slate-300 text-center"
            navigate={~p"/#{@thread.title}/post/new"}
          >
            Create a Post
          </.link>
        </div>
        <div class="text-center text-xs mt-4">
          <p>The official ByteExchange community thread!</p>
        </div>
      </div>
    </div>
    """
  end
end
