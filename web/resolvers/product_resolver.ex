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
    # FIXME there must be a better way to extract values from a struct
    %{
      id: Map.fetch!(product, :Id),
      price: Map.fetch!(product, :Price),
      description: map_description(Map.fetch!(product, :Description)),
      category: map_category(Map.fetch!(product, :Category)),
      group: map_group(Map.fetch!(product, :Group))
    }
  end

  def map_description(description) do
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

  def map_group(group) do
    # category is used as a map
    %{
      id: group["Id"],
      name: group["Name"]
    }
  end

  def create_product_map(dto_struct) do
    dto_struct
      |> map_to_product_schema_type
  end

  def all(_args, creds) do
    url = getProductUrl()
    headers =["ApiKey": get_api_key(creds)]
    options = []

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Poison.decode!(body, as: [Product])
          |> Enum.map(&create_product_map/1)
        {:ok, result}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ok, []}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:ok, reason}
    end
  end
end
