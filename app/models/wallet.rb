class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :transactions_as_source, class_name: "Transaction", foreign_key: :source_wallet_id
  has_many :transactions_as_target, class_name: "Transaction", foreign_key: :target_wallet_id

  # Ensure balance stays accurate when transactions occur
  def debit!(amount)
    raise "Insufficient funds" if self.balance < amount

    self.balance -= amount
    save!
  end

  def credit!(amount)
    self.balance += amount
    save!
  end

  def balance
    # Sum of all credits (deposits) and debits (withdrawals) for this wallet
    credits = transactions_as_target.sum(:amount) # Money received
    debits = transactions_as_source.sum(:amount)  # Money sent
    credits - debits
  end
  
end