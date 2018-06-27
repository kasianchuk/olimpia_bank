FactoryBot.define do
  factory :account do
    balance 5000
    currency 'uah'
    user
  end
end
