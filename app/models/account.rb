class Account < ApplicationRecord
  belongs_to :user

  validates :balance, presence: true

  has_many :deposits, dependent: :destroy
  has_many :withdraws, dependent: :destroy
end
