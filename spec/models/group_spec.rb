require 'rails_helper'

RSpec.describe Group, type: :model do
  subject { User.new(name: 'User A', email: 'usera@gmail.com', password: '123bhu') }

  before { subject.save }
  # before { subject.save }
  it 'Group inharitans from ApplicationRecord' do
    expect(Group < ApplicationRecord).to eq(true)
  end
  context 'validations' do
    it 'Name of Group should be group 1' do
      group = Group.create!(user_id: subject.id, name: 'group 1',
                            icon: 'https://uxwing.com/wp-content/themes/uxwing/download/beauty-fashion/beauty-cream-icon.png')

      expect(group.name).to eq('group 1')
    end
    it 'should be valid when the user exist' do
      group = Group.create!(user_id: subject.id, name: 'group 1',
                            icon: 'https://uxwing.com/wp-content/themes/uxwing/download/beauty-fashion/beauty-cream-icon.png')
      expect(group).to be_valid
    end

    it 'Not valid with out user' do
      group = Group.create(name: 'group 1',
                           icon: 'https://uxwing.com/wp-content/themes/uxwing/download/beauty-fashion/beauty-cream-icon.png')
      expect(group.errors[:user]).to include('must exist')
    end

    it 'Name must be present' do
      group = Group.create(user_id: subject.id,
                           icon: 'https://uxwing.com/wp-content/themes/uxwing/download/beauty-fashion/beauty-cream-icon.png')
      expect(group.errors[:name]).to include("can't be blank")
    end

    it 'not valid when icon is not url' do
      group = Group.create(user_id: subject.id, name: 'group 1', icon: 'this must be link')
      expect(group.errors[:icon]).to include('must be a valid URL')
    end
  end
end
