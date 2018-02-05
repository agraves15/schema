class Scheme < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :schemes_users, dependent: :destroy
  has_many :users, through: :schemes_users
  has_many :colors_schemes, dependent: :destroy
  has_many :colors, through: :colors_schemes
  accepts_nested_attributes_for :colors

  def add_color(scheme_params, id)
    return if scheme_params[:colors_attributes][id.to_s][:name].empty?
    color = Color.new(name: scheme_params[:colors_attributes][id.to_s][:name].upcase)
    color.save
    colors.append color
  end

  def add_user(shared)
    users.append shared
  end

  def remove_user(unshared)
    users.delete unshared
  end
end
