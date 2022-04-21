defmodule SockethangWeb.TestItemLive.Index do
  use SockethangWeb, :live_view

  alias Sockethang.TestContext
  alias Sockethang.TestContext.TestItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :test_items, list_test_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Test item")
    |> assign(:test_item, TestContext.get_test_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Test item")
    |> assign(:test_item, %TestItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Test items")
    |> assign(:test_item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    test_item = TestContext.get_test_item!(id)
    {:ok, _} = TestContext.delete_test_item(test_item)

    {:noreply, assign(socket, :test_items, list_test_items())}
  end

  defp list_test_items do
    TestContext.list_test_items()
  end
end
