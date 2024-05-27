defmodule ByteExchangeWeb.PostLive.Component do
  use Phoenix.Component

  import ByteExchangeWeb.CoreComponents

  def post(assigns) do
    ~H"""
    <.link
      navigate={"/thread/#{@post.thread.title}/post/#{@post.id}"}
      class="flex gap-4 p-2 bg-slate-900 m-4 w-full rounded-md shadow-2xl h-fit"
      id={@id}
    >
      <div class="flex flex-col items-center">
        <.icon name="hero-arrow-up-circle" />
        <span><%= @post.upvote_count %></span>
        <.icon name="hero-arrow-down-circle" />
      </div>
      <div>
        <div><%= @post.title %></div>
        <div>
          By <%= @post.user.email %> <%= @post.inserted_at %> days ago in <%= @post.thread.title %>
        </div>
      </div>
    </.link>
    """
  end
end
