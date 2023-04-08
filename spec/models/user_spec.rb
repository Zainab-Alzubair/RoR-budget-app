require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'User1', email: 'user1@gmail.com', password: '12345') }

  before { subject.save }
  it 'User inharitans from ApplicationRecord' do
    expect(User < ApplicationRecord).to eq(true)
  end

  it 'return corrent name' do
    expect(subject.name).to eq('User1')
  end

  it 'Return correct bio validate' do
    expect(subject.email).to eq('user1@gmail.com')
  end

  it 'Name Should be lenght greter than 5' do
    subject.name = 'za'
    expect(subject).to_not be_valid
  end
end