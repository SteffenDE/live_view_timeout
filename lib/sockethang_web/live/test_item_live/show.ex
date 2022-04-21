defmodule SockethangWeb.TestItemLive.Show do
  use SockethangWeb, :live_view

  alias Sockethang.TestContext

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:test_item, TestContext.get_test_item!(id))}
  end

  defp page_title(:show), do: "Show Test item"
  defp page_title(:edit), do: "Edit Test item"
end
