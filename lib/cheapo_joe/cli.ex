defmodule CheapoJoe.CLI do

	def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

	def parse_args(argv) do
    args = OptionParser.parse(
      argv,
      strict: [help: :boolean, cities: :boolean],
      alias: [h: :help]
    )

    case args do
    	{[], [], []} ->
        :list_yard_sales

      {[cities: true], _, _} ->
        :choose_city

      {[help: true], _, _} ->
        :help

      {[], [], [{"-h", nil}]} ->
        :help

      _ ->
        :invalid_arg
    end
  end

  defp process(:help) do
    IO.puts """
    cheapojoe --yard_sales # Look for yard sales around Durham!
    cheapojoe --help       # A helping hand from CheapJoe
    cheapojoe --cities     # Choose city to find yard sales in
    """
    System.halt(0)
  end

  defp process(:choose_city) do
    CheapoJoe.enter_city_selection_flow()
  end

  defp process(:list_yard_sales) do
  	# TODO: A general top-level "yard_sales" that combines input from different sites
    Scrapers.YardSaleSearch.yard_sales()
  end

  defp process(:invalid_arg) do
    IO.puts "Invalid argument(s) passed. Take a gander at usage below:"
    process(:help)
  end
end