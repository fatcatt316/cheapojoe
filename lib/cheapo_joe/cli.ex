defmodule CheapoJoe.CLI do

	def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

	def parse_args(argv) do
    args = OptionParser.parse(
      argv, 
      strict: [help: :boolean, yard_sales: :boolean], # TODO: Different args
      alias: [h: :help]
    )

    case args do
    	{[], [], []} ->
        :list_yard_sales
        
      {[help: true], _, _} ->
        :help

      {[], [], [{"-h", nil}]} ->
        :help

      _ ->
        :invalid_arg
    end
  end

  def process(:help) do
    IO.puts """
    cheapojoe --yard_sales  # Look for yard sales around Durham!
    """
    System.halt(0)
  end

  def process(:list_yard_sales) do
  	# TODO: A general top-level "yard_sales" that combines input from different sites
    Scrapers.YardSaleSearch.yard_sales
  end

  def process(:invalid_arg) do
    IO.puts "Invalid argument(s) passed. See usage below:"
    process(:help)
  end
end