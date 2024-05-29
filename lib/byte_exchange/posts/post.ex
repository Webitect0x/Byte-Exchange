defmodule ByteExchange.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :description, :string
    field :title, :string
    field :upvote_count, :integer, default: 0
    belongs_to :thread, ByteExchange.Threads.Thread
    belongs_to :user, ByteExchange.Accounts.User
    has_many :comments, ByteExchange.Comments.Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :thread_id, :user_id])
    |> validate_required([:title, :description, :thread_id, :user_id])
  end
end
