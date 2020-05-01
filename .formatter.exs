# Used by "mix format"
[
  import_deps: [:ecto, :ecto_sql],
  inputs: [
    "*.{ex,exs}",
    "{mix,.formatter}.exs",
    "priv/*/seeds.exs",
    "{config,lib,test}/**/*.{ex,exs}"
  ],
  subdirectories: ["priv/*/migrations"]
]
