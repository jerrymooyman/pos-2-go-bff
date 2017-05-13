defmodule Pos2gobff.MemberResolver do
  import Pos2gobff.AuthResolver

  defmodule Member do
    @derive [Poison.Encoder]
    defstruct [:Id,
               :FirstName,
               :Surname,
               :DateOfBirth,
               :HomePhone,
               :MobilePhone,
               :EmailAddress
              ]
  end

  @member_query "Member/{id}"

  defp get_member_url(id) do 
    member_query = String.replace(@member_query, "{id}", id, global: false)
    base_url = Application.get_env(:pos2gobff, :api_base_url)
    Enum.join([base_url, member_query])
  end

  defp map_member(member) do
    m = Map.from_struct(member)
     %{
       id: m[:Id],
       first_name: m[:FirstName],
       surname: m[:Surname],
     }
  end

  def find(%{id: id}, _info) do
    url = get_member_url(id)
    headers =["ApiKey": get_api_key()]
    options = []

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Poison.decode!(body, as: Member)
          |> map_member
        IO.puts inspect(result)
        {:ok, result}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ok, %{}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:ok, reason}
    end

  end
end

