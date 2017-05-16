defmodule Pos2gobff.Context do
  @moduledoc """
  This module is just a regular plug that can look at the conn struct and build
  the appropriate absinthe context.
  """

  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    put_private(conn, :absinthe, %{context: context})
  end

  def build_context(conn) do
    %{location_id: get_req_header(conn, "locationid") |> Enum.at(0),
      user_id: get_req_header(conn, "userid") |> Enum.at(0),
      password: get_req_header(conn, "password") |> Enum.at(0)
    }
  end
end
