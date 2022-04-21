defmodule Sockethang.TestContext do
  @moduledoc """
  The TestContext context.
  """

  import Ecto.Query, warn: false
  alias Sockethang.Repo

  alias Sockethang.TestContext.TestItem

  @doc """
  Returns the list of test_items.

  ## Examples

      iex> list_test_items()
      [%TestItem{}, ...]

  """
  def list_test_items do
    # Repo.all(TestItem)
    Repo.all(from t in TestItem, order_by: t.name)
  end

  @doc """
  Gets a single test_item.

  Raises `Ecto.NoResultsError` if the Test item does not exist.

  ## Examples

      iex> get_test_item!(123)
      %TestItem{}

      iex> get_test_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test_item!(id), do: Repo.get!(TestItem, id)

  @doc """
  Creates a test_item.

  ## Examples

      iex> create_test_item(%{field: value})
      {:ok, %TestItem{}}

      iex> create_test_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test_item(attrs \\ %{}) do
    %TestItem{}
    |> TestItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test_item.

  ## Examples

      iex> update_test_item(test_item, %{field: new_value})
      {:ok, %TestItem{}}

      iex> update_test_item(test_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test_item(%TestItem{} = test_item, attrs) do
    test_item
    |> TestItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a test_item.

  ## Examples

      iex> delete_test_item(test_item)
      {:ok, %TestItem{}}

      iex> delete_test_item(test_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test_item(%TestItem{} = test_item) do
    Repo.delete(test_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test_item changes.

  ## Examples

      iex> change_test_item(test_item)
      %Ecto.Changeset{data: %TestItem{}}

  """
  def change_test_item(%TestItem{} = test_item, attrs \\ %{}) do
    TestItem.changeset(test_item, attrs)
  end
end
