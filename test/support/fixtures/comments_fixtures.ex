defmodule ByteExchange.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ByteExchange.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content",
        upvote_count: 42
      })
      |> ByteExchange.Comments.create_comment()

    comment
  end
end
