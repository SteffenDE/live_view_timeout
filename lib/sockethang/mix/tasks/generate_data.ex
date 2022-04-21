defmodule Mix.Tasks.GenerateData do
  use Mix.Task
  # import Ecto.Query

  def run(args) do
    {opts, _} = OptionParser.parse!(args, strict: [num: :integer])
    num = Keyword.fetch!(opts, :num)

    Mix.Task.run("app.start")

    for i <- 1..num do
      Sockethang.TestContext.create_test_item(
        %{
          name: "testitem-#{i}",
          foo: "text #{i}",
          bar: "more text #{i}",
          baz: "another text #{i}"
        }
      )
    end

    IO.puts("generated #{num} items")
  end
end
