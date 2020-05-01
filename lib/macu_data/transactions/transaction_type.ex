defmodule MacuData.Transactions.TransactionType do
  use EctoEnum, type: :transaction_type, enums: [:debit, :credit, :check]
end
