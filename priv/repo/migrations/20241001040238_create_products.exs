defmodule StoreApi.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :text
      add :price, :float
      add :stock, :float
      add :category_id, references(:categories, on_delete: :nothing)
      add :store_id, references(:stores, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:products, [:category_id])
    create index(:products, [:store_id])
  end
end
