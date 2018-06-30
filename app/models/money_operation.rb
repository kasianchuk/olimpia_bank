class MoneyOperation < ApplicationRecord
  belongs_to :account

  scope :by_deposit, ->(id) { where(id: id) }
  scope :by_withdraw, ->(id) { where(id: id) }

  # scope :all_deposits, -> {account_id}
  def account_id_currency
    "#{account.id} - #{account.currency}"
  end

  def transaction_time
    created_at.try(:strftime, '%d %B %Y')
  end
end
