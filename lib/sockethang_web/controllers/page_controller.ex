defmodule SockethangWeb.PageController do
  use SockethangWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
