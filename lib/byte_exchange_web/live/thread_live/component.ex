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
end
