require 'rails_helper'

describe 'money operation', type: :feature do
  it 'withdraw' do
    visit '/accounts/1/deposits/new'
    fill_in 'calculation[amount]', with: '100'
    fill_in 'Account ID', with: '1'
    click_button 'Save'
    expect(page).to have_content 'Success'
  end
end
