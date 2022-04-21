defmodule SockethangWeb.TestItemLive.FormComponent do
  use SockethangWeb, :live_component

  alias Sockethang.TestContext

  @impl true
  def update(%{test_item: test_item} = assigns, socket) do
    changeset = TestContext.change_test_item(test_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"test_item" => test_item_params}, socket) do
    changeset =
      socket.assigns.test_item
      |> TestContext.change_test_item(test_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"test_item" => test_item_params}, socket) do
    save_test_item(socket, socket.assigns.action, test_item_params)
  end

  defp save_test_item(socket, :edit, test_item_params) do
    case TestContext.update_test_item(socket.assigns.test_item, test_item_params) do
      {:ok, _test_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Test item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_test_item(socket, :new, test_item_params) do
    case TestContext.create_test_item(test_item_params) do
      {:ok, _test_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Test item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
