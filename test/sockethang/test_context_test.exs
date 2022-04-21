defmodule Sockethang.TestContextTest do
  use Sockethang.DataCase

  alias Sockethang.TestContext

  describe "test_items" do
    alias Sockethang.TestContext.TestItem

    import Sockethang.TestContextFixtures

    @invalid_attrs %{bar: nil, baz: nil, foo: nil, name: nil}

    test "list_test_items/0 returns all test_items" do
      test_item = test_item_fixture()
      assert TestContext.list_test_items() == [test_item]
    end

    test "get_test_item!/1 returns the test_item with given id" do
      test_item = test_item_fixture()
      assert TestContext.get_test_item!(test_item.id) == test_item
    end

    test "create_test_item/1 with valid data creates a test_item" do
      valid_attrs = %{bar: "some bar", baz: "some baz", foo: "some foo", name: "some name"}

      assert {:ok, %TestItem{} = test_item} = TestContext.create_test_item(valid_attrs)
      assert test_item.bar == "some bar"
      assert test_item.baz == "some baz"
      assert test_item.foo == "some foo"
      assert test_item.name == "some name"
    end

    test "create_test_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TestContext.create_test_item(@invalid_attrs)
    end

    test "update_test_item/2 with valid data updates the test_item" do
      test_item = test_item_fixture()
      update_attrs = %{bar: "some updated bar", baz: "some updated baz", foo: "some updated foo", name: "some updated name"}

      assert {:ok, %TestItem{} = test_item} = TestContext.update_test_item(test_item, update_attrs)
      assert test_item.bar == "some updated bar"
      assert test_item.baz == "some updated baz"
      assert test_item.foo == "some updated foo"
      assert test_item.name == "some updated name"
    end

    test "update_test_item/2 with invalid data returns error changeset" do
      test_item = test_item_fixture()
      assert {:error, %Ecto.Changeset{}} = TestContext.update_test_item(test_item, @invalid_attrs)
      assert test_item == TestContext.get_test_item!(test_item.id)
    end

    test "delete_test_item/1 deletes the test_item" do
      test_item = test_item_fixture()
      assert {:ok, %TestItem{}} = TestContext.delete_test_item(test_item)
      assert_raise Ecto.NoResultsError, fn -> TestContext.get_test_item!(test_item.id) end
    end

    test "change_test_item/1 returns a test_item changeset" do
      test_item = test_item_fixture()
      assert %Ecto.Changeset{} = TestContext.change_test_item(test_item)
    end
  end
end
