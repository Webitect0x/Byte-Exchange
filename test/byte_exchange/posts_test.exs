defmodule ByteExchange.PostsTest do
  use ByteExchange.DataCase

  alias ByteExchange.Posts

  describe "posts" do
    alias ByteExchange.Posts.Post

    import ByteExchange.PostsFixtures

    @invalid_attrs %{description: nil, title: nil, upvote_count: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        upvote_count: 42
      }

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.description == "some description"
      assert post.title == "some title"
      assert post.upvote_count == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        upvote_count: 43
      }

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.description == "some updated description"
      assert post.title == "some updated title"
      assert post.upvote_count == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
