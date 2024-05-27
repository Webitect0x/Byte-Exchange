defmodule ByteExchangeWeb.PostCreationLive do
  use ByteExchangeWeb, :live_view

  alias ByteExchange.{Threads, Posts}
  alias ByteExchange.Posts.Post

  def mount(%{"thread_title" => thread_title}, _session, socket) do
    thread_id = Threads.get_thread_id(thread_title)

    socket =
      socket
      |> assign_form(Posts.change_post(%Post{}))
      |> assign(:thread_id, thread_id)
      |> assign(:thread_title, thread_title)

    {:ok, socket}
  end

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def handle_event("validate", %{"post" => post_params}, socket) do
    changeset =
      %Post{}
      |> Posts.change_post(post_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    attrs =
      Map.merge(
        %{
          "user_id" => socket.assigns.current_user.id,
          "thread_id" => socket.assigns.thread_id
        },
        post_params
      )

    case Posts.create_post(attrs) do
      {:ok, post} ->
        socket =
          socket
          |> assign_form(Posts.change_post(%Post{}))
          |> push_navigate(to: ~p"/thread/#{socket.assigns.thread_title}/post/#{post.id}")

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  def render(assigns) do
    ~H"""
    <.form for={@form} phx-change="validate" phx-submit="save">
      <.input type="text" field={@form[:title]} label="Title" />
      <.input type="text" field={@form[:description]} label="Description" />
      <.button>Save</.button>
    </.form>
    """
  end
end
