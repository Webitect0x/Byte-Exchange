defmodule ByteExchangeWeb.UpvoteCount do
  use Phoenix.Component

  import ByteExchangeWeb.CoreComponents

  attr :rest, :global
  attr :upvote_count, :integer

  def upvote_count(assigns) do
    ~H"""
    <div {@rest}>
      <.icon name="hero-arrow-up-circle" />
      <span><%= @upvote_count %></span>
      <.icon name="hero-arrow-down-circle" />
    </div>
    """
  end
end
