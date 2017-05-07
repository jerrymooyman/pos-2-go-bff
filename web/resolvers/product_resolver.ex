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

  def all(_args, _info) do
    # products = [
    #   %{
    #     id: "1",
    #     name: "coffee"}
    # ]
    
    url = getProductUrl()
    authKey = get_api_key()
    headers =["ApiKey": authKey]
    options = []

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        product = Poison.decode!(body, as: AuthToken)
        IO.puts inspect(body)
    #     # IO.puts Map.get(Poison.decode!(body, as: AuthToken), :ApiKey)
    #     {:ok, products}
        {:ok, []}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ok, []}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:ok, reason}
    end
  end
end
