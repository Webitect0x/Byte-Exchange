defmodule ByteExchangeWeb.PostLive.Component do
  use Phoenix.Component

  import ByteExchangeWeb.{Utils, UpvoteCount}
  alias ByteExchange.Comment

  def post(assigns) do
    ~H"""
    <.link
      navigate={"/thread/#{@post.thread.title}/post/#{@post.id}"}
      class="flex gap-4 p-2 bg-slate-900 border border-slate-800 m-4 w-full rounded-md shadow-2xl h-fit"
      id={@id}
    >
      <.upvote_count class="flex flex-col items-center gap-1" upvote_count={@post.upvote_count} />
      <div>
        <div><%= @post.title %></div>
        <div>
          By <%= @post.user.email %> <%= days_ago(@post.inserted_at) %> in <%= @post.thread.title %>
        </div>
      </div>
    </.link>
    """
  end

  attr :id, :integer, required: true
  attr :comment, Comment

  def comment(assigns) do
    ~H"""
    <div
      id={@id}
      class="flex gap-2 m-6 p-2 w-[95%] items-center  border border-slate-800 shadow-xl rounded-md"
    >
      <.upvote_count class="flex flex-col items-center gap-1" upvote_count={@comment.upvote_count} />
      <div>
        <div class="text-sm font-bold">
          <%= @comment.user.email %>
          <span class="text-slate-400 italic"><%= days_ago(@comment.inserted_at) %></span>
        </div>
        <p><%= @comment.content %></p>
      </div>
    </div>
    """
  end
end
