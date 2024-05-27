defmodule ByteExchangeWeb.PostLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.Posts

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    {:noreply, socket |> assign(post: Posts.get_post!(id))}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex justify-between">
      <div class="bg-slate-900 shadow-xl m-5 flex h-full w-full">
        <div class="w-full">
          <div class="flex justify-between items-center">
            <h1 class="m-5 font-bold text-2xl"><%= @post.title %></h1>
            <div class="flex gap-1">
              <.icon name="hero-arrow-up-circle" />
              <span><%= @post.upvote_count %></span>
              <.icon name="hero-arrow-down-circle" />
            </div>
          </div>
          <div class=" bg-slate-700 h-[0.1rem] m-5"></div>
          <p class="p-10"><%= @post.description %></p>
          <div class="text-xs italic p-3">21 Comments</div>
          <.comments />
        </div>
      </div>

      <div class="bg-slate-900 h-[100vh] mr-3 justify-end relative w-fit hidden lg:block p-4 rounded-md shadow-2xl">
        <h2 class="text-2xl font-bold text-center p-2 w-[15rem]"><%= @post.thread.title %></h2>
        <div class="text-center text-xs">
          <span><%= @post.thread.subscribers %> Subscribers</span>
        </div>
        <div class="flex flex-col mt-5 gap-3 justify-center">
          <.button>Subscribe</.button>
          <.button>Chatroom</.button>
          <.link
            class=" rounded-lg bg-slate-950 shadow-xl hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-slate-300 text-center"
            navigate={~p"/#{@post.thread.title}/post/new"}
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

  def comments(assigns) do
    ~H"""
    <div class="p-4">
      <h1 class="text-xl font-bold">Comments</h1>
      <div class="text-xs">Sort By: <span class="text-slate-400">Top Comments</span></div>
      <.comment />
    </div>
    """
  end

  def comment(assigns) do
    ~H"""
    <div class="flex gap-2 items-center p-4">
      <div class="flex flex-col items-center">
        <.icon name="hero-arrow-up-circle" />
        <span>0</span>
        <.icon name="hero-arrow-down-circle" />
      </div>
      <div>
        <div class="text-sm font-bold">
          Username <span class="text-slate-400 italic">2 hours ago</span>
        </div>
        <p>Comment</p>
      </div>
    </div>
    """
  end
end
