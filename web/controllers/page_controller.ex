defmodule Pos2gobff.PageController do
  use Pos2gobff.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
