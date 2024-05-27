defmodule ByteExchange.ThreadsTest do
  use ByteExchange.DataCase

  alias ByteExchange.Threads

  describe "threads" do
    alias ByteExchange.Threads.Thread

    import ByteExchange.ThreadsFixtures

    @invalid_attrs %{title: nil, subscribers: nil, post_count: nil}

    test "list_treads/0 returns all threads" do
      thread = thread_fixture()
      assert Threads.list_treads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Threads.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      valid_attrs = %{title: "some title", subscribers: 42, post_count: 42}

      assert {:ok, %Thread{} = thread} = Threads.create_thread(valid_attrs)
      assert thread.title == "some title"
      assert thread.subscribers == 42
      assert thread.post_count == 42
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Threads.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      update_attrs = %{title: "some updated title", subscribers: 43, post_count: 43}

      assert {:ok, %Thread{} = thread} = Threads.update_thread(thread, update_attrs)
      assert thread.title == "some updated title"
      assert thread.subscribers == 43
      assert thread.post_count == 43
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Threads.update_thread(thread, @invalid_attrs)
      assert thread == Threads.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Threads.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Threads.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Threads.change_thread(thread)
    end
  end
end
