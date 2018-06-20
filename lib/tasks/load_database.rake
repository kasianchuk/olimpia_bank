# frozen_string_literal: true

# rake load_database:loading

namespace :load_database do
  desc 'Load from yaml'

  task loading: :environment do
    require 'yaml'
    data = YAML.load_file('config/imported_data.yml')
    arr = []
    index = 0

    data['users'].each do |_, user_data|
      user = User.create!(name:     user_data['name'],
                          password: user_data['password'])
      arr.push(user.id, user.id)
    end

    data['accounts'].each do |_, account_data|
      Account.create!(balance:  account_data['balance'],
                      currency: account_data['currency'],
                      user_id:  arr[index])
      index += 1
    end
  end
end