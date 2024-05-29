defmodule ByteExchangeWeb.PostLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.Posts
  alias ByteExchange.Comments
  alias ByteExchange.Comments.Comment

  import ByteExchangeWeb.Utils
  import ByteExchangeWeb.{ThreadLive.Component, PostLive.Component, UpvoteCount}

  def render(assigns) do
    ~H"""
    <div class="flex justify-between h-[100vh]">
      <div class="bg-slate-900 overflow-scroll rounded-md border border-slate-800 p-4 mx-2 shadow-xl  flex h-full w-full">
        <div class="w-full">
          <div class="flex justify-between items-center">
            <h1 class="m-5 font-bold text-2xl">
              <div class="text-slate-400 text-xs italic">
                User <%= @post.user.email %>
              </div>
              <%= @post.title %>
            </h1>
            <.upvote_count class="flex items-center gap-1" upvote_count={@post.upvote_count} />
          </div>
          <div class=" bg-slate-700 h-[0.1rem] m-5"></div>
          <p class="p-10"><%= @post.description %></p>

          <span class="text-xs p-10 italic text-slate-400">
            Created <%= days_ago(@post.inserted_at) %>
          </span>
          <div class="p-4">
            <h1 class="text-xl font-bold">Comments</h1>
            <div class="text-xs">Sort By: <span class="text-slate-400">Top Comments</span></div>
          </div>
          <div class="text-xs italic px-5">
            <%= Enum.count(@streams.comments) %> Comments
          </div>
          <.comment
            :for={{comment_id, comment} <- @streams.comments}
            comment={comment}
            id={comment_id}
          />

          <%= if !@current_user do %>
            <div>
              <p>Sign in to comment</p>
            </div>
          <% else %>
            <.form for={@form} phx-submit="comment">
              <.input type="textarea" name="content" value="" placeholder="Add a comment..." />
              <.button>Post</.button>
            </.form>
          <% end %>
        </div>
      </div>
      <.thread_bar title={@post.thread.title} subscribers={@post.thread.subscribers} />
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     assign_form(
       socket,
       Comments.change_comment(%Comment{})
     )}
  end

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, form: to_form(changeset))
  end

  def handle_params(%{"id" => id}, _url, socket) do
    comments = Enum.reverse(Comments.list_comments_by_post(id))

    socket =
      socket
      |> stream(:comments, comments)
      |> assign(post: Posts.get_post!(id))

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("comment", %{"content" => content}, socket) do
    attrs = %{
      post_id: socket.assigns.post.id,
      user_id: socket.assigns.current_user.id,
      content: content
    }

    case Comments.create_comment(attrs) do
      {:ok, _comment} ->
        {:noreply, socket |> assign_form(Comments.change_comment(%Comment{}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign_form(changeset)}
    end
  end
end
