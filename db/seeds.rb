# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)
require 'yaml'
data = YAML.load_file('config/imported_data.yml')
user_ids = {}
account_ids = {}

data['users'].each do |user_id, user_data|
  user = User.create!(name:  user_data['name'],
                      email: "#{user_data['name']}@olimpia.com",
                      password: user_data['password'])
  user_ids[user_id] = user.id
end

data['accounts'].each do |account_id, account_data|
  account = Account.create!(balance:  account_data['balance'],
                            currency: account_data['currency'],
                            user_id:  user_ids[account_data['user_id']])
  account_ids[account_id] = account.id
end

data['deposits'].each do |_, deposit_data|
  MoneyOperation.create!(amount:  deposit_data['amount'],
                         operation: 'deposit',
                         account_id:  account_ids[deposit_data['account_id']])
end

data['witdraws'].each do |_, withdraw_data|
  MoneyOperation.create!(amount:  withdraw_data['amount'],
                         operation: 'withdraw',
                         account_id:  account_ids[withdraw_data['account_id']])
end
