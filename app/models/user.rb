require 'bcrypt'

class User < ActiveRecord::Base
  validates :name, :email, :password_hash, presence: true
  validates :name, :email, uniqueness: true
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :user
  has_many :schemes_users, dependent: :destroy
  has_many :schemes, through: :schemes_users

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
