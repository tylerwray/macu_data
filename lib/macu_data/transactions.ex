defmodule MacuData.Transactions do
  @moduledoc """
  Grouped functionality revolving around transactions.
  """


  alias MacuData.Repo
  alias MacuData.Transactions.CSVLoader
  alias MacuData.Transactions.Transaction

  @doc """
  Load transactions from an exported MACU CSV.

  ## Examples

      iex> load_from_csv("data.csv")
      [%Transaction{}, %Transaction{}, ...]
  """
  def load_from_csv(file_path) do
    CSVLoader.call(file_path)
  end

  @doc """
  Convert a cents amount to a string
  formatted in US Dollars.

  ## Examples

    iex> amount_to_usd(123456)
    "$1,234.56"

    iex> amount_to_usd(654)
    "$6.54"

    iex> amount_to_usd(4)
    "$0.04"

  """
  def amount_to_usd(cents) do
    cents
    |> Money.new(:USD)
    |> Money.to_string()
  end

  @doc """
  Stream all transactions from the Database.

  ## Examples

      iex> load_from_csv("data.csv")
      [%Transaction{}, %Transaction{}, ...]

  """
  def all do
    Repo.all(Transaction)
  end
end
