defmodule MyApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :bio, :string
      add :password_hash, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
