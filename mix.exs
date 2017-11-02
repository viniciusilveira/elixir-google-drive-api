defmodule ElixirGoogleDriveApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_google_drive_api,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
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
      {:mock, "~> 0.2.0", only: :test}
    ]
  end
end
