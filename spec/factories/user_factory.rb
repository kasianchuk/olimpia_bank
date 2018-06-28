FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "user#{i}" }
    sequence(:email) { |i| "user#{i}@example.com" }
    password 'password'
    token { SecureRandom.uuid }
  end
end
