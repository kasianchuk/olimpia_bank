class UserSerializer < ActiveModel::Serializer
  has_many :accounts
  attributes :id, :name, :email
end
