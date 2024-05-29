defmodule ByteExchangeWeb.ThreadLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.{Threads, Posts}
  alias ByteExchangeWeb.PostFormLive

  import ByteExchangeWeb.{PostLive.Component, ThreadLive.Component}

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="w-full">
        <.post :for={{post_id, post} <- @streams.posts} id={post_id} post={post} />
      </div>
      <.thread_bar title={@thread.title} subscribers={@thread.subscribers} />
      <div :if={@live_action in [:new]}>
        <.modal id="new-post" show on_cancel={JS.navigate(~p"/thread/#{@thread.title}")}>
          <.live_component
            module={PostFormLive}
            id="post-form"
            thread_title={@thread.title}
            thread_id={@thread.id}
            current_user={@current_user}
          />
        </.modal>
      </div>
    </div>
    """
  end

  def mount(%{"thread_title" => thread_title}, _session, socket) do
    thread = Threads.get_thread_by_title!(thread_title)
    posts = Posts.list_posts_by_thread(thread.id)

    socket =
      socket
      |> stream(:posts, posts)
      |> assign(:thread, thread)

    {:ok, socket}
  end
end
