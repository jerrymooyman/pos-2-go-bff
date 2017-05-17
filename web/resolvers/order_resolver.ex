defmodule Pos2gobff.OrderResolver do
  import Pos2gobff.AuthResolver


  @order_fragment "Order"

  defp get_order_url() do
    base_url = Application.get_env(:pos2gobff, :api_base_url)
    base_url <> @order_fragment
  end

  # defp map_member(member) do
  #   m = Map.from_struct(member)
  #    %{
  #      id: m[:Id],
  #      first_name: m[:FirstName],
  #      surname: m[:Surname],
  #    }
  # end


  args = %{ created_date: nil,
            scheduled_order_date: nil,
            booking_name: nil,
            member_id: nil
          }
  
  def create(args, creds) do
    IO.puts inspect(args)



    # url = get_member_url(id)
    # headers = ["ApiKey": get_api_key(creds)]
    # options = []

    # case HTTPoison.get(url, headers, options) do
    #   {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    #     result = Poison.decode!(body, as: Member)
    #       |> map_member
    #     {:ok, result}
    #   {:ok, %HTTPoison.Response{status_code: code}} when code in 400..499  ->
    #     {:ok, %{}}
    #   {:error, %HTTPoison.Error{reason: reason}} ->
    #     {:ok, reason}
    # end
    {:ok, nil}
  end
end

