
defmodule Pos2gobff.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "a product"
  object :product do
    field :id, :string
    field :price, :float
    field :description, :description
    field :category, :category
    field :group, :group
  end

  object :description do
    field :standard, :string
    field :short, :string
  end

  object :category do
    field :id, :integer
    field :name, :string
  end

  object :group do
    field :id, :integer
    field :name, :string
  end

  @desc "a member"
  object :member do
    field :id, :integer
    field :first_name, :string
    field :surname, :string
    field :date_of_birth, :string
    field :home_phone, :string
    field :mobile_phone, :string
    field :email_address, :string
  end

end
