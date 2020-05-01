defmodule MacuData.Repo.Migrations.CreateTransactions do
  use Ecto.Migration
  alias MacuData.Transactions.TransactionType

  def change do
    TransactionType.create_type()

    create table(:transactions) do
      add :long_id, :string, null: false
      add :posting_date, :date, null: false
      add :effective_date, :date, null: false
      add :type, TransactionType.type(), null: false
      add :amount, :integer, null: false, default: 0
      add :check_number, :integer
      add :reference_number, :integer, null: false
      add :description, :string, null: false
      add :category, :string
      add :balance, :integer
    end

    create unique_index(:transactions, [:long_id])
    create unique_index(:transactions, [:reference_number])
  end
end
