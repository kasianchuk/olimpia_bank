class Deposit < ApplicationRecord
  belongs_to :account

  scope :by_id, ->(id) { where(id: id) }

  # scope :all_deposits, -> {account_id}
  def account_id_currency
    "#{account.id} - #{account.currency}"
  end


  def transaction_time
    created_at.try(:strftime, '%d %B %Y')
  end

end
