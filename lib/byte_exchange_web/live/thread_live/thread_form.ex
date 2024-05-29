defmodule ByteExchangeWeb.ThreadLive.ThreadForm do
  use ByteExchangeWeb, :live_component

  alias ByteExchange.Threads
  alias ByteExchange.Threads.Thread

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-2xl font-bold">Thread Creation</h1>
      <.form for={@form} phx-submit="submit" phx-target={@myself}>
        <.input field={@form[:title]} label="Thread Title" />
        <.input type="textarea" field={@form[:description]} label="Thread Description" />
        <.button phx-disable-with="Creating..." class="mt-4">
          Create
        </.button>
      </.form>
    </div>
    """
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_form(Threads.change_thread(%Thread{}))

    {:ok, socket}
  end

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    socket
    |> assign(:form, to_form(changeset))
  end

  def handle_event("submit", %{"thread" => thread_params}, socket) do
    attrs = Map.merge(thread_params, %{"user_id" => socket.assigns.current_user.id})

    case Threads.create_thread(attrs) do
      {:ok, thread} ->
        socket =
          socket
          |> assign_form(Threads.change_thread(%Thread{}))
          |> push_navigate(to: ~p"/thread/#{thread.title}")

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end
end
