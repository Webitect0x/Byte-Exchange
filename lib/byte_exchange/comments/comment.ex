defmodule ByteExchange.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :content, :string
    field :upvote_count, :integer, default: 0
    belongs_to :user, ByteExchange.Accounts.User
    belongs_to :post, ByteExchange.Posts.Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :upvote_count, :user_id, :post_id])
    |> validate_required([:content, :upvote_count, :user_id, :post_id])
  end
end
