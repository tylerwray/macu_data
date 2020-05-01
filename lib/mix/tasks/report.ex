defmodule Mix.Tasks.Report do
  @moduledoc """
  Load transactions from a CSV file exported from MACU.

  ## Examples
  4
  """
  use Mix.Task

  alias MacuData.Transactions

  @shortdoc "Load transactions from a CSV."

  def run(_) do
    Mix.Task.run("app.start")

    Transactions.all()
    |> Enum.each(&print/1)
  end

  defp print(%{type: :debit, amount: amount, balance: balance}) do
    IO.write("Spent\t\t")

    amount
    |> Transactions.amount_to_usd()
    |> light_red()
    |> IO.write()

    print_balance(balance)

    IO.write("\n")
  end

  defp print(%{type: type, amount: amount, balance: balance}) when type in [:credit, :check] do
    IO.write("Earned\t\t")

    amount
    |> Transactions.amount_to_usd()
    |> light_green()
    |> IO.write()

    print_balance(balance)

    IO.write("\n")
  end

  defp print_balance(balance) do
    IO.write("\t\t\t")

    balance
    |> Transactions.amount_to_usd()
    |> light_yellow()
    |> IO.write()
  end

  defp light_green(text) do
    IO.ANSI.light_green() <> text <> IO.ANSI.reset()
  end

  defp light_red(text) do
    IO.ANSI.light_red() <> text <> IO.ANSI.reset()
  end

  defp light_yellow(text) do
    IO.ANSI.light_yellow() <> text <> IO.ANSI.reset()
  end
end
