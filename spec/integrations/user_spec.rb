require 'rails_helper'
RSpec.feature 'Logins', type: :feature do
  subject { User.new(name: 'Zainab A', email: 'test@gmail.com', password: 'password', role: 'user') }
  #   before { subject.skip_confirmation! }
  it 'click the login error' do
    visit 'users/sign_up'
    click_button 'Sign up'
    expect(page).to have_content "Email can't be blank"
  end
  it 'click the login error' do
    subject.save
    visit 'users/sign_up'
    fill_in 'user[email]', with: 'test@gmail.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content "Name can't be blank"
  end
end
