defmodule ByteExchange.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ByteExchange.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        upvote_count: 42,
        user_id: UUID.uuid1(),
        thread_id: UUID.uuid1()
      })
      |> ByteExchange.Posts.create_post()

    post
  end
end
