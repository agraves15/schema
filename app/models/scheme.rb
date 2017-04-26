class Scheme < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :schemes_users, dependent: :destroy
  has_many :users, through: :schemes_users
  has_many :colors_schemes, dependent: :destroy
  has_many :colors, through: :colors_schemes
  accepts_nested_attributes_for :colors
  accepts_nested_attributes_for :users

  def add_color(scheme_params, id)
    return if scheme_params[:colors_attributes][id.to_s][:name].empty?
    color = Color.new(name: scheme_params[:colors_attributes][id.to_s][:name].upcase)
    color.save
    colors.append color
  end

  def add_user(scheme_params, id)
    return if scheme_params[:users_attributes][id.to_s][:name].to_i.zero?
    share = User.find(scheme_params[:users_attributes][id.to_s][:id])
    users.append share
  end
end
