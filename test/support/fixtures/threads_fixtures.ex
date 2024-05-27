defmodule ByteExchange.ThreadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ByteExchange.Threads` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, thread} =
      attrs
      |> Enum.into(%{
        post_count: 42,
        subscribers: 42,
        title: "some title"
      })
      |> ByteExchange.Threads.create_thread()

    thread
  end
end
