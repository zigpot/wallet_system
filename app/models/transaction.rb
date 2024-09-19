class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, inclusion: { in: %w[credit debit transfer] }

  # Perform the transaction
  def process!
    case transaction_type
    when "credit"
      raise "Invalid credit transaction" if source_wallet.present?

      target_wallet.credit!(amount)
    when "debit"
      raise "Invalid debit transaction" if target_wallet.present?

      source_wallet.debit!(amount)
    when "transfer"
      raise "Invalid transfer transaction" if source_wallet.nil? || target_wallet.nil?

      source_wallet.debit!(amount)
      target_wallet.credit!(amount)
    end
  end
end
