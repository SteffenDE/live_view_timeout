defmodule Sockethang.Repo.Migrations.CreateTestItems do
  use Ecto.Migration

  def change do
    create table(:test_items) do
      add :name, :string
      add :foo, :string
      add :bar, :string
      add :baz, :string

      timestamps()
    end
  end
end
