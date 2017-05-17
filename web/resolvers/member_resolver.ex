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
    member_query = String.replace(@member_query, "{id}", "#{id}")
    base_url = Application.get_env(:pos2gobff, :api_base_url)
    base_url <> member_query
  end

  defp map_member(member) do
    m = Map.from_struct(member)
     %{
       id: m[:Id],
       first_name: m[:FirstName],
       surname: m[:Surname],
     }
  end

  def find(%{id: id}, creds) do
    url = get_member_url(id)
    headers = ["ApiKey": get_api_key(creds)]
    options = []

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Poison.decode!(body, as: Member)
          |> map_member
        {:ok, result}
      {:ok, %HTTPoison.Response{status_code: code}} when code in 400..499  ->
        {:ok, %{}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:ok, reason}
    end
  end
end

