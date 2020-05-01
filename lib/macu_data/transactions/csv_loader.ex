defmodule MacuData.Transactions.CSVLoader do
  @moduledoc """
  Load data from an MACU data CSV.

    1. Extract it's contents.
    2. Transform it's data.
    3. Load it into our data store.

  """

  alias MacuData.Repo
  alias MacuData.Transactions.Transaction

  @doc """
  Load data from an exported MACU CSV.

  ## Examples

      iex> call("data.csv")
      [%Transaction{}, %Transaction{}, ...]

  """
  def call(file_path) do
    file_path
    |> extract()
    |> Stream.map(&transform/1)
    |> Stream.chunk_every(500)
    |> Stream.map(&load/1)
    |> Enum.to_list()
  end

  defp extract(file_path) do
    file_path
    |> File.stream!()
    |> CSV.decode!(headers: true)
  end

  defp transform(%{
         "Transaction ID" => long_id,
         "Posting Date" => posting_date,
         "Effective Date" => effective_date,
         "Transaction Type" => type,
         "Amount" => amount,
         "Check Number" => check_number,
         "Reference Number" => reference_number,
         "Description" => description,
         "Transaction Category" => category,
         "Balance" => balance
       }) do
    %{
      long_id: long_id,
      posting_date: parse_date(posting_date),
      effective_date: parse_date(effective_date),
      type: convert_type(type),
      amount: to_cents(amount),
      check_number: parse_integer(check_number),
      reference_number: parse_integer(reference_number),
      description: description,
      category: check_nil(category),
      balance: to_cents(balance)
    }
  end

  defp parse_date(date) do
    [month, day, year] = String.split(date, "/", trim: true)

    {:ok, date} =
      Date.new(String.to_integer(year), String.to_integer(month), String.to_integer(day))

    date
  end

  defp convert_type("Debit"), do: :debit
  defp convert_type("Credit"), do: :credit
  defp convert_type("Check"), do: :check

  defp to_cents(amount) do
    amount
    |> String.to_float()
    |> Float.round(2)
    |> Kernel.*(100)
    |> round()
    |> abs()
  end

  defp parse_integer(""), do: nil
  defp parse_integer(x), do: String.to_integer(x)

  defp check_nil(""), do: nil
  defp check_nil(x), do: x

  defp load(transactions) do
    Repo.insert_all(Transaction, transactions)
  end
end
