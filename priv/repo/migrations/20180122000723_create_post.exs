defmodule MyApp.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :message, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
