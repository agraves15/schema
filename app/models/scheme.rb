class Scheme < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :schemes_users, dependent: :destroy
  has_many :users, through: :schemes_users
  has_many :colors_schemes, dependent: :destroy
  has_many :colors, through: :colors_schemes
end
