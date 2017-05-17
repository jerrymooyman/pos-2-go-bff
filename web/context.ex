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

  defp default_if_empty(list) do
    case list do
      [] -> [nil]
      [_] -> list
    end
  end

  def build_context(conn) do
    %{location_id: get_req_header(conn, "locationid") |> default_if_empty |> hd,
      user_id: get_req_header(conn, "userid") |> default_if_empty |> hd,
      password: get_req_header(conn, "password") |> default_if_empty |> hd
    }
  end
end
