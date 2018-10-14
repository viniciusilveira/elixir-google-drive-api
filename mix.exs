defmodule ElixirGoogleDriveApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_google_drive_api,
      version: "0.4.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      package: package(),
      description: description(),
      deps: deps(),
      source_url: "https://github.com/viniciusilveira/elixir-google-drive-api",
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.json": :test,
      ],
      test_coverage: [tool: ExCoveralls],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.0"},
      {:goth, "~> 0.4.0"},
      {:mock, "~> 0.2.0", only: :test},
      {:credo, "~> 0.8.1", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.7", only: :test},
    ]
  end

  def description do
    "Elixir library to work files of Google Drive"
  end

  defp package do
    [
      name: "elixir_google_drive_api",
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Marcos Vinicius O. Silveira"],
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/viniciusilveira/elixir-google-drive-api"}
    ]
  end
end
