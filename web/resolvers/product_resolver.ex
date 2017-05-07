defmodule Pos2gobff.ProductResolver do
  def all(_args, _info) do
    products = [
      %{
        id: "1",
        name: "coffee"}
    ]
    {:ok, products}
  end
end
