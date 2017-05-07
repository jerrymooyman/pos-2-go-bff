defmodule Pos2gobff.AuthResolver do
  defmodule AuthToken do
    @derive [Poison.Encoder]
    defstruct [:ApiKey]
  end

  @baseUrl "http://webstores.swiftpos.com.au:4000/SwiftApi/api/"
  @authQuery "Authorisation?locationId=1&userId=0&password=0"

  defp get_auth_url() do
    Enum.join([@baseUrl, @authQuery])
  end

  def get_api_key() do
    case HTTPoison.get(get_auth_url()) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Map.get(Poison.decode!(body, as: AuthToken), :ApiKey)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        ""
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
  end
end

