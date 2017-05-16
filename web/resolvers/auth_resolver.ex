defmodule Pos2gobff.AuthResolver do
  defmodule AuthToken do
    @derive [Poison.Encoder]
    defstruct [:ApiKey]
  end

  @auth_query "Authorisation?locationId={location_id}&userId={user_id}&password={password}"

  defp get_auth_url(creds) do
    creds
    |> inspect
    |> IO.puts
    auth_query = String.replace(@auth_query, "{location_id}", creds.location_id)
    |> String.replace("{user_id}", creds.user_id)
    |> String.replace("{password}", creds.password)
    base_url = Application.get_env(:pos2gobff, :api_base_url)
    Enum.join([base_url, auth_query])
  end

  def get_api_key(creds) do
    case HTTPoison.get(get_auth_url(creds)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Map.get(Poison.decode!(body, as: AuthToken), :ApiKey)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        ""
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
  end
end

