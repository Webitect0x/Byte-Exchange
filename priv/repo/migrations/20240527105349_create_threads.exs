defmodule ByteExchange.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :subscribers, :integer
      add :post_count, :integer
      add :description, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:threads, [:title])
  end
end
