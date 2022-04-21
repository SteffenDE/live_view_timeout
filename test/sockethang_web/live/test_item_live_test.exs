defmodule SockethangWeb.TestItemLiveTest do
  use SockethangWeb.ConnCase

  import Phoenix.LiveViewTest
  import Sockethang.TestContextFixtures

  @create_attrs %{bar: "some bar", baz: "some baz", foo: "some foo", name: "some name"}
  @update_attrs %{bar: "some updated bar", baz: "some updated baz", foo: "some updated foo", name: "some updated name"}
  @invalid_attrs %{bar: nil, baz: nil, foo: nil, name: nil}

  defp create_test_item(_) do
    test_item = test_item_fixture()
    %{test_item: test_item}
  end

  describe "Index" do
    setup [:create_test_item]

    test "lists all test_items", %{conn: conn, test_item: test_item} do
      {:ok, _index_live, html} = live(conn, Routes.test_item_index_path(conn, :index))

      assert html =~ "Listing Test items"
      assert html =~ test_item.bar
    end

    test "saves new test_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.test_item_index_path(conn, :index))

      assert index_live |> element("a", "New Test item") |> render_click() =~
               "New Test item"

      assert_patch(index_live, Routes.test_item_index_path(conn, :new))

      assert index_live
             |> form("#test_item-form", test_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#test_item-form", test_item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.test_item_index_path(conn, :index))

      assert html =~ "Test item created successfully"
      assert html =~ "some bar"
    end

    test "updates test_item in listing", %{conn: conn, test_item: test_item} do
      {:ok, index_live, _html} = live(conn, Routes.test_item_index_path(conn, :index))

      assert index_live |> element("#test_item-#{test_item.id} a", "Edit") |> render_click() =~
               "Edit Test item"

      assert_patch(index_live, Routes.test_item_index_path(conn, :edit, test_item))

      assert index_live
             |> form("#test_item-form", test_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#test_item-form", test_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.test_item_index_path(conn, :index))

      assert html =~ "Test item updated successfully"
      assert html =~ "some updated bar"
    end

    test "deletes test_item in listing", %{conn: conn, test_item: test_item} do
      {:ok, index_live, _html} = live(conn, Routes.test_item_index_path(conn, :index))

      assert index_live |> element("#test_item-#{test_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#test_item-#{test_item.id}")
    end
  end

  describe "Show" do
    setup [:create_test_item]

    test "displays test_item", %{conn: conn, test_item: test_item} do
      {:ok, _show_live, html} = live(conn, Routes.test_item_show_path(conn, :show, test_item))

      assert html =~ "Show Test item"
      assert html =~ test_item.bar
    end

    test "updates test_item within modal", %{conn: conn, test_item: test_item} do
      {:ok, show_live, _html} = live(conn, Routes.test_item_show_path(conn, :show, test_item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Test item"

      assert_patch(show_live, Routes.test_item_show_path(conn, :edit, test_item))

      assert show_live
             |> form("#test_item-form", test_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#test_item-form", test_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.test_item_show_path(conn, :show, test_item))

      assert html =~ "Test item updated successfully"
      assert html =~ "some updated bar"
    end
  end
end
