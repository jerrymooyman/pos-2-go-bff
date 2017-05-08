defmodule Pos2gobff.Router do
  use Phoenix.Router

  # pipeline :graphql do
  #   plug Pos2gobff.Context
  # end

  scope "/" do
    # pipe_through :graphql

    get "/graphiql", Absinthe.Plug.GraphiQL, schema: Pos2gobff.Schema
    post "/graphiql", Absinthe.Plug.GraphiQL, schema: Pos2gobff.Schema
    forward "/graphql", Absinthe.Plug, schema: Pos2gobff.Schema
  end
end
