defmodule Scrapers do
  defmodule YardSaleSearch do
    # TODO: allow city to be passed in
    # List available cities as options
    # VALID_CITIES = ["Durham", "Asheville", etc.]
    @cities ["Asheville", "Durham"]

    # TODO: Somehow associate these cities with state abbreviations, too

    def cities do
      @cities
    end

    @doc """
    Fetch a list of all of yardsales matching search criteria
    TODO: Allow search criteria to be passed in (date, city, etc.)
    """
    def yard_sales() do
      case HTTPoison.get(search_url()) do
        {:ok, response} ->
          case response.status_code do
            200 ->
              yard_sales = response.body
                |> Floki.find("div.event[id]")
                |> Enum.map(&extract_city_and_address/1)
              {:ok, yard_sales}

            _ -> :error
          end
        _ -> :error
      end
    end

    defp search_url(city \\ "Durham", state \\ "NC") do
    # @base_url "https://www.yardsalesearch.com/garage-sales-durham-nc.html"
    # @multi_sales "https://www.yardsalesearch.com/garage-sales.html?week=0&date=2018-03-24&zip=Durham%2C+North+Carolina&r=100&q="
      "https://www.yardsalesearch.com/garage-sales-#{city}-#{state}.html"
    end

    defp extract_city_and_address(yard_sale) do
      %{
        street_address: extract_by_itemprop(yard_sale, "streetAddress"),
        city: extract_by_itemprop(yard_sale, "addressLocality")
      }
    end

    defp extract_by_itemprop(yard_sale, itemprop_name) do
      {_, _, results} = Floki.find(yard_sale, "span[itemprop=#{itemprop_name}]")
        |> List.first

      hd(results)
    end
  end
end
