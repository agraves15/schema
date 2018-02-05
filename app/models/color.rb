class Color < ApplicationRecord
  validates :name, presence: true
  has_many :colors_schemes, dependent: :destroy
  has_many :schemes, through: :colors_schemes
end
