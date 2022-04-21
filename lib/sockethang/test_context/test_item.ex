defmodule Sockethang.TestContext.TestItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "test_items" do
    field :bar, :string
    field :baz, :string
    field :foo, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(test_item, attrs) do
    test_item
    |> cast(attrs, [:name, :foo, :bar, :baz])
    |> validate_required([:name, :foo, :bar, :baz])
  end
end
