defmodule ByteExchange.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :upvote_count, :integer
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :post_id, references(:posts, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:comments, [:user_id])
    create index(:comments, [:post_id])
  end
end
