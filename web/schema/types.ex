
defmodule Pos2gobff.Schema.Types do
  use Absinthe.Schema.Notation

  object :product do
    field :id, :string
    field :price , :float
    field :description, :description
    field :category, :category
  end

  object :description do
    field :standard , :string
    field :short , :string
  end

  object :category do
    field :id , :integer
    field :name , :string
  end

end
