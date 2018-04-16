defmodule CheapoJoe.MixProject do
  use Mix.Project

  def project do
    [
      app: :cheapojoe,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: CheapoJoe.CLI],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.20.0"},
      {:httpoison, "~> 1.1.0"}
    ]
  end
end
