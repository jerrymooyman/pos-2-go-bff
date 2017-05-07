defmodule Pos2gobff.Router do
  use Phoenix.Router

  forward "/", Absinthe.Plug,
    schema: Pos2gobff.Schema
end
