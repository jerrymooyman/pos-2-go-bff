defmodule Pos2gobff.Schema do
  use Absinthe.Schema
  import_types Pos2gobff.Schema.Types

  query do
    field :products, list_of(:product) do
      resolve &Pos2gobff.ProductResolver.all/2
    end
    field :member, type: :member do
      arg :id, non_null(:id)
      resolve &Pos2gobff.MemberResolver.find/2
    end
  end

end
