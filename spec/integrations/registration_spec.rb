require 'rails_helper'

RSpec.feature 'Registrations', type: :feature do
  subject { User.new(name: 'Hello Zainab', email: 'test@gmail.com', password: 'password', role: 'admin') }
  #   before { subject.skip_confirmation! }
  before { subject.save }
  it 'can enter a name and receive a greeting' do
    visit new_user_registration_path
    expect(page).to have_content 'Registration'
  end
  it 'click the login error' do
    visit 'users/sign_up'
    click_button 'Sign up'
    expect(page).to have_content "Email can't be blank"
  end
  it 'click the login error' do
    visit 'users/sign_up'
    fill_in 'user[email]', with: 'test@gmail.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content "Name can't be blank"
  end
  it 'click the login error' do
    visit 'users/sign_up'
    fill_in 'user[name]', with: 'Zaina'
    fill_in 'user[email]', with: 'test@gmail.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Name is too short (minimum is 6 characters)'
  end
end
