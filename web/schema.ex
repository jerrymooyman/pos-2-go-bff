defmodule Pos2gobff.Schema do
  use Absinthe.Schema
  import_types Pos2gobff.Schema.Types

  query do
    field :products, list_of(:product) do
      resolve fn(x, %{context: %{location_id: location_id, user_id: user_id, password: password}}) ->
        context = %{location_id: location_id, user_id: user_id, password: password}
        Pos2gobff.ProductResolver.all(x, context)
      end
    end
    field :member, type: :member do
      arg :id, non_null(:id)
      resolve fn(x, %{context: %{location_id: location_id, user_id: user_id, password: password}}) ->
        context = %{location_id: location_id, user_id: user_id, password: password}
        Pos2gobff.MemberResolver.find(x, context)
      end
    end
  end

end
