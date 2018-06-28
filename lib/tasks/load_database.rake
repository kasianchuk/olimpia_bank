# rake load_database:loading

namespace :load_database do
  desc 'Load from yaml'

  task loading: :environment do
    require 'yaml'
    data = YAML.load_file('config/imported_data.yml')
    arr = []
    index = 0

    data['users'].each do |_, user_data|
      user = User.find_or_create_by(name:     user_data['name'],
                                    email: "#{user_data['name']}@olimpia.com",
                                    password: user_data['password'])
      arr.push(user.id, user.id)
    end

    data['accounts'].each do |_, account_data|
      Account.find_or_create_by(balance:  account_data['balance'],
                                currency: account_data['currency'],
                                user_id:  arr[index])
      index += 1
    end

    data['deposits'].each do |_, deposit_data|
      MoneyOperation.find_or_create_by(amount:  deposit_data['amount'],
                                       operation: 'deposit',
                                       account_id:  Account.first.id)
    end

    data['witdraws'].each do |_, withdraw_data|
      MoneyOperation.find_or_create_by(amount:  withdraw_data['amount'],
                                       operation: 'withdraw',
                                       account_id:  Account.first.id)
    end
  end
end
