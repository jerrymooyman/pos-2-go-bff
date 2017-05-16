defmodule Pos2gobff.Schema do
  use Absinthe.Schema
  import_types Pos2gobff.Schema.Types

  query do
    field :products, list_of(:product) do
      resolve &Pos2gobff.ProductResolver.all/2
    end
    field :member, type: :member do
      arg :id, non_null(:id)
      resolve fn(x, %{context: %{location_id: location_id, user_id: user_id, password: password}}) ->
        Pos2gobff.MemberResolver.find(x, %{location_id: location_id, user_id: user_id, password: password})
      end
    end
  end

end
