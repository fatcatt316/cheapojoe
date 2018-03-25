defmodule CheapoJoe do
  def enter_city_selection_flow() do
    IO.puts("Hold on a tick while I find available cities...")
    # TODO: Top-level scraper that gets info from multiple sites
    # case Scraper.get_locations() do
    #   {:ok, locations} ->
    #     {:ok, location} = ask_user_to_select_location(locations)
    #     display_soup_list(location)

    #   :error ->
    #     IO.puts("An unexpected error occurred. Please try again.")
    # end
    IO.puts("One moment while I fetch the list of locations...")
    {:ok, city} = ask_user_to_select_city(Scrapers.YardSaleSearch.cities)
    display_yard_sales(city)
  end

  @config_file "~/.cheapo_joe" # location of the local file in which default location is saved

  @doc """
  Prompt the user to select a city to see yard sales in.

  The city's name will be saved to @config_file for future lookups.
  This function can only ever return a {:ok, city} tuple because an invalid
  selection will result in this funtion being recursively called.
  """
  def ask_user_to_select_city(cities) do
    # Print an indexed list of the cities
    cities
    |> Enum.with_index(1)
    |> Enum.each(fn({city, index}) -> IO.puts(" #{index} - #{city}") end) # TODO: Tighten up

    case IO.gets("Choose a city number: ") |> Integer.parse() do
      :error ->
        IO.puts("Invalid selection. Try again.")
        ask_user_to_select_city(cities)

      {city_nb, _} ->
        case Enum.at(cities, city_nb - 1) do
          nil ->
            IO.puts("Invalid city number :( Try again!")
            ask_user_to_select_city(cities)

          city ->
            IO.puts("You've selected #{city}, excellent choice.")
            File.write!(Path.expand(@config_file), to_string(:erlang.term_to_binary(city)))
            {:ok, city}
        end
    end
  end

 def display_yard_sales(city) do
    IO.puts("One moment while I search out some yard sales in #{city}...")
    # case Scraper.get_soups(location.id) do # TODO: Pass in city
    case Scrapers.YardSaleSearch.yard_sales do
      {:ok, yard_sales} ->
        yard_sales
        |> Enum.each(fn(yard_sale) -> IO.puts("#{yard_sale[:street_address]}, #{yard_sale[:city]}, NC") end)
      _ ->
        IO.puts("Shucks, we got an error. Try again, or select a city using `cheapo_joe --cities` (TODO: THIS)")
    end
  end
end
