defmodule SockethangWeb.TestLive do
  use SockethangWeb, :live_view

  def mount(_params, _session, socket) do
    socket
    |> assign_new(:foobar, fn ->
      %{cool: :stuff}
    end)
    |> tap(fn socket ->
      if connected?(socket) do
        Phoenix.PubSub.subscribe(Sockethang.PubSub, "foochannel")
      end
    end)
    |> then(&{:ok, assign(&1, data: generate_data())})
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stuff")
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stuff")
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stuff")
  end

  def render(assigns) do
    ~H"""
    <table>
      <%= for d <- @data do %>
        <tr>
          <td><%= d.name %></td>
          <td><%= d.data %></td>
        </tr>
      <% end %>
    </table>
    """
  end

  defp generate_data() do
    Enum.map(1..10000, fn i -> %{
      name: "random",
      data: "foobar-#{i}"
    } end)
  end
end
