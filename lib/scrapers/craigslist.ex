require IEx
defmodule Scrapers.Craigslist do
	# TODO: allow city to be passed in
  # List available cities as options
  # VALID_CITIES = ["Durham", "Asheville", etc.]
  @cities ["Asheville", "Durham"]

	def yard_sales() do
    case HTTPoison.get(search_url()) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            yard_sales = response.body
              |> Floki.find("li.result-row")
              |> Enum.map(&extract_url/1)
            {:ok, yard_sales}

          _ -> :error
        end
      _ -> :error
    end
  end

  defp search_url(city \\ "Durham", date \\ (Date.utc_today |> Date.to_iso8601)) do
    # @base_url "https://raleigh.craigslist.org/search/gms?query=durham&sale_date=2018-04-07"
    "https://raleigh.craigslist.org/search/gms?query=#{city}&sale_date=#{date}"
  end

  defp extract_url(yard_sale) do
  	yard_sale
  	|> Floki.find("a.hdrlnk")
  	|> Floki.attribute("href")
  end
end