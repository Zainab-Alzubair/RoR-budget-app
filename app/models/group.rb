class Group < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_and_belongs_to_many :payments, dependent: :destroy
  validates :name, presence: true
  validates :icon, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: 'must be a valid URL' }
end
