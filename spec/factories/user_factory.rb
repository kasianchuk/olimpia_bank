FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "user#{i}" }
    sequence(:email) { |i| "user#{i}@example.com" }
    password 'password'
    token { SecureRandom.uuid }
  end

  factory :bad_user, class: User do
    name 'hacker'
    email 'hacker@example.com'
    password 'password'
    token 'tra-li-li'
  end

  factory :current_user, class: User do
    name 'Bond'
    email 'bond007@example.com'
    password 'password'
    token { SecureRandom.uuid }
  end
end
