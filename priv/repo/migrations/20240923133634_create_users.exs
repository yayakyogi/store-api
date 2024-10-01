defmodule StoreApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :role, :string, null: false, default: "user"

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, :email)
  end
end
