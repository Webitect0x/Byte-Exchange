defmodule ByteExchange.Threads.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "threads" do
    field :title, :string
    field :description, :string
    field :subscribers, :integer, default: 0
    field :post_count, :integer, default: 0
    belongs_to :user, ByteExchange.Accounts.User
    has_many :post, ByteExchange.Posts.Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:title, :description, :user_id, :post_count, :subscribers])
    |> validate_required([:title, :description, :user_id])
    |> unique_constraint(:title)
  end
end
