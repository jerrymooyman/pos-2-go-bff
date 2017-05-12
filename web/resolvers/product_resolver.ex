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
    @derive [Poison.Encoder]
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

  def map_to_product_schema_type(product) do
    # product is used as a struct
    %{
      id: Map.fetch!(product, :Id),
      price: Map.fetch!(product, :Price),
      description: map_to_product_description_schema_type(Map.fetch!(product, :Description)),
      category: map_category(Map.fetch!(product, :Category))
    }
  end

  def map_to_product_description_schema_type(description) do
    # description is used as a map
    %{
      standard: description["Standard"],
      short: description["Short"]
    }
  end

  def map_category(category) do
    # category is used as a map
    %{
      id: category["Id"],
      name: category["Name"]
    }
  end

  def create_product_map(dto_struct) do
    dto_struct
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
