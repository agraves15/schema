class Scheme < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :schemes_users, dependent: :destroy
  has_many :users, through: :schemes_users
  has_many :colors_schemes, dependent: :destroy
  has_many :colors, through: :colors_schemes
  accepts_nested_attributes_for :colors

  def add_color(scheme_params, id)
    return false if scheme_params[:colors_attributes]["#{id}"][:name].empty?
    color = Color.new(name: scheme_params[:colors_attributes]["#{id}"][:name].upcase)
    color.save
    colors.append color
  end
end
