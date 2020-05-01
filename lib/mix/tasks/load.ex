defmodule Mix.Tasks.Load do
  @moduledoc """
  Load transactions from a CSV file exported from MACU.

  ## Examples

    $ mix load ./data.csv

  """
  use Mix.Task

  alias MacuData.Transactions

  @shortdoc "Load transactions from a CSV."

  def run([file_path]) do
    Mix.Task.run("app.start")

    Transactions.load_from_csv(file_path)
  end
end
