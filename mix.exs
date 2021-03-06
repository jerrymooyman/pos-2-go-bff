defmodule Pos2gobff.Mixfile do
  use Mix.Project

  def project do
    [app: :pos2gobff,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Pos2gobff, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext, :absinthe, :absinthe_plug, :httpoison, :poison]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:absinthe, "~> 1.3.0"},
     {:absinthe_plug, "~> 1.2"},
     {:absinthe_ecto, git: "https://github.com/absinthe-graphql/absinthe_ecto.git"},
     {:httpoison, "~> 0.11.1"},
     {:poison, "~> 1.5"},
     {:cowboy, "~> 1.0"},

     {:exrm, "~> 1.0.8"}
    ]
  end
end
