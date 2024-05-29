defmodule ByteExchangeWeb.ThreadLive.Component do
  use Phoenix.Component

  alias ByteExchange.Threads.Thread
  import ByteExchangeWeb.CoreComponents

  attr :thread, Thread, required: true
  attr :id, :integer, required: true
  attr :rest, :global

  def thread(assigns) do
    ~H"""
    <div id={@id} {@rest}>
      <.icon name="hero-question-mark-circle" />
      <.link navigate={"/thread/#{@thread.title}"}><%= @thread.title %></.link>
      <div class="text-sm text-gray-500 ml-8">
        <%= @thread.subscribers %> subscribers
      </div>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :subscribers, :integer, required: true

  def thread_bar(assigns) do
    ~H"""
    <div class="m-8 h-[100vh] w-[23rem] mr-3 justify-end relative hidden lg:block p-4 rounded-md shadow-2xl">
      <h2 class="text-2xl font-bold text-center p-2 w-[15rem]"><%= @title %></h2>
      <div class="text-center text-xs">
        <span><%= @subscribers %> Subscribers</span>
      </div>
      <div class="flex flex-col mt-5 gap-3 justify-center">
        <.button>Subscribe</.button>
        <.button>Chatroom</.button>
        <.link
          class="rounded-lg bg-slate-950 shadow-xl hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-slate-300 text-center"
          navigate={"/thread/#{@title}/post/new"}
        >
          Create a Post
        </.link>
      </div>
      <div class="text-center text-xs mt-4">
        <p>The official ByteExchange community thread!</p>
      </div>
    </div>
    """
  end
end
