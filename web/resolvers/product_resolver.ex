defmodule Pos2gobff.ProductResolver do
  import Pos2gobff.AuthResolver

  defmodule Product do
    @derive [Poison.Encoder]
    defstruct [:Id,
               :InventoryCode,
               :ProductGuid,
               :Description,
               :Category,
               :Group,
               :Price,
               :Image
              ]
  end
  defmodule Description do
    defstruct [
      :Standard,
      :Short,
      :Long,
      :Notes
    ]
  end
  defmodule Category do
    defstruct [
      :Id,
      :Name
    ]
  end
  defmodule Group do
    defstruct [
      :Id,
      :Name
    ]
  end

  @baseUrl "http://webstores.swiftpos.com.au:4000/SwiftApi/api/"
  @productQuery "Product?categoryId=232"

  defp getProductUrl() do
    Enum.join([@baseUrl, @productQuery])
  end

  def map_to_product_schema_type(dto_map) do
    %{
      id: Map.fetch!(dto_map, :Id),
      price: Map.fetch!(dto_map, :Price)
    }
  end

  def create_product_map(dto_struct) do
    dto_struct
      |> Map.from_struct
      |> map_to_product_schema_type
  end

  def all(_args, _info) do
    url = getProductUrl()
    headers =["ApiKey": get_api_key()]
    options = []

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Poison.decode!(body, as: [Product])
          |> Enum.map(fn(x) -> create_product_map(x) end)
        {:ok, result}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ok, []}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:ok, reason}
    end
  end
end
