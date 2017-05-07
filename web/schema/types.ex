
defmodule Pos2gobff.Schema.Types do
  use Absinthe.Schema.Notation

  object :product do
    field :id, :string
    field :name , :string
  end

end
