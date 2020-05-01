defmodule MacuData.Transactions.Transaction do
  @moduledoc """
  An ecto schema for holding a MACU transaction record.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias MacuData.Transactions.TransactionType

  @type t :: %__MODULE__{}

  schema "transactions" do
    field :long_id, :string
    field :posting_date, :date
    field :effective_date, :date
    field :type, TransactionType
    field :amount, :integer
    field :check_number, :integer
    field :reference_number, :integer
    field :description, :string
    field :category, :string
    field :balance, :integer
  end

  def changeset(transaction, params \\ %{}) do
    transaction
    |> cast(params, [
      :long_id,
      :posting_date,
      :effective_date,
      :type,
      :amount,
      :check_number,
      :reference_number,
      :description,
      :category,
      :balance
    ])
    |> validate_required([
      :long_id,
      :posting_date,
      :effective_date,
      :type,
      :amount,
      :reference_number,
      :description,
      :balance
    ])
    |> unique_constraint(:long_id)
    |> unique_constraint(:reference_number)
    |> EctoEnum.validate_enum(:type)
  end
end
