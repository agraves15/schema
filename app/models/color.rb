class Color < ActiveRecord::Base
  validates :name, :r, :g, :b, presence: true
  validates :name, uniqueness: true
  validates :r, :g, :b, numericality: { greater_than_or_equal_to: 0 }
  validates :r, :g, :b, numericality: { less_than_or_equal_to: 255 }
  has_many :colors_schemes, dependent: :destroy
  has_many :schemes, through: :colors_schemes
end
