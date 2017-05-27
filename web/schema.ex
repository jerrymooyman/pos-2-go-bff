defmodule Pos2gobff.Schema do
  use Absinthe.Schema
  import_types Pos2gobff.Schema.Types

  creds = %{location_id: nil, user_id: nil, password: nil}

  query do
    @desc "get categories"
    field :category, list_of(:category) do
      resolve fn(x, %{context: creds}) ->
        Pos2gobff.CategoryResolver.all(x, creds)
      end
    end


    @desc "get products"
    field :products, list_of(:product) do
      resolve fn(x, %{context: creds}) ->
        Pos2gobff.ProductResolver.all(x, creds)
      end
    end

    @desc "get member"
    field :member, type: :member do
      arg :id, non_null(:id)
      resolve fn(x, %{context: creds}) ->
        Pos2gobff.MemberResolver.find(x, creds)
      end
    end
  end

  mutation do
    @desc "create product order"
    field :order, type: :order do
      arg :created_date, non_null(:string)
      arg :scheduled_order_date, non_null(:string)
      arg :booking_name, non_null(:string)
      arg :member_id, non_null(:integer)
      # arg :items, list_of(:item)

      resolve fn(x, %{context: creds}) ->
        Pos2gobff.OrderResolver.create(x, creds)
      end
    end

  end

end
