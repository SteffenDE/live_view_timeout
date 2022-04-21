defmodule Sockethang.TestContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sockethang.TestContext` context.
  """

  @doc """
  Generate a test_item.
  """
  def test_item_fixture(attrs \\ %{}) do
    {:ok, test_item} =
      attrs
      |> Enum.into(%{
        bar: "some bar",
        baz: "some baz",
        foo: "some foo",
        name: "some name"
      })
      |> Sockethang.TestContext.create_test_item()

    test_item
  end
end
