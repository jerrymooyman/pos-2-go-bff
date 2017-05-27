defmodule Pos2gobff.CategoryResolver do
  import Pos2gobff.AuthResolver

  defmodule Category do
    @derive [Poison.Encoder]
    defstruct [:Id,
               :Name
              ]
  end
  
  @resource_query "Family"

  defp get_resource_url() do
    base_url = Application.get_env(:pos2gobff, :api_base_url)
    base_url <> @resource_query
  end

  defp map_category(category) do
    %{
      id: Map.fetch!(category, :Id),
      name: Map.fetch!(category, :Name)
    }
  end

  def all(_args, creds) do
    url = get_resource_url()
    headers =["ApiKey": get_api_key(creds)]
    options = []

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Poison.decode!(body, as: [Category])
        |> Enum.map(&map_category/1)
        {:ok, result}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ok, []}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:ok, reason}
    end
  end
end

