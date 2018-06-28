class AccountSerializer < ActiveModel::Serializer
  has_many :money_operations
  attributes :id, :balance, :currency, :user_id
end
