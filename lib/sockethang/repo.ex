defmodule Sockethang.Repo do
  use Ecto.Repo,
    otp_app: :sockethang,
    adapter: Ecto.Adapters.Postgres
end
