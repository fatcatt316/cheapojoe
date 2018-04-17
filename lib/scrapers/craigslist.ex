require IEx
defmodule Scrapers.Craigslist do
	# TODO: allow city to be passed in
  # List available cities as options
  # VALID_CITIES = ["Durham", "Asheville", etc.]
  # @cities ["Asheville", "Durham"]

	def yard_sales() do
    case HTTPoison.get(search_url()) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            yard_sales = response.body
            |> Floki.find("li.result-row")
            |> Enum.map(&extract_url/1)
            |> Enum.map(&extract_city_and_address/1)

            {:ok, yard_sales}

          _ -> :error
        end
      _ -> :error
    end
  end

  defp search_url(city \\ "Durham", date \\ (Date.utc_today |> Date.to_iso8601)) do
    # @base_url "https://raleigh.craigslist.org/search/gms?query=durham&sale_date=2018-04-15"
    "https://raleigh.craigslist.org/search/gms?query=#{city}&sale_date=#{date}"
  end

  defp extract_url(yard_sale) do
  	yard_sale
    |> Floki.find("a.hdrlnk")
    |> Floki.attribute("href")
  end

  defp extract_city_and_address(yard_sale_url) do
    case HTTPoison.get(yard_sale_url) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            yard_sales = response.body
            |> process_yard_sale(valid_address?(response.body))

            {:ok, yard_sales}

          _ -> :error
        end
      _ -> :error
    end
  end

  defp process_yard_sale(_yard_sale, valid_address) when valid_address != true do
    {}
  end

  defp process_yard_sale(yard_sale, valid_address) when valid_address do
    %{
      street_address: extract_street_address(yard_sale),
      city: extract_city(yard_sale)
    }
  end

  # TODO: This doesn't really get the city at all... just the Google Maps URL
  defp extract_city(yard_sale) do
    yard_sale
    |> Floki.find("p.mapaddress")
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> hd()
  end

  defp extract_street_address(yard_sale) do
    yard_sale
    |> Floki.find("div.mapaddress")
    |> List.first
    |> Floki.FlatText.get(" ")
  end

  # TODO: Is this really the best way to test for a valid address?
  defp valid_address?(yard_sale) do
    yard_sale
    |> Floki.find("div[data-accuracy=10]")
    |> Enum.any?
  end
end