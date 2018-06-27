class Account < ApplicationRecord
  belongs_to :user

  validates :balance, presence: true

  has_many :money_operations, dependent: :destroy
end
