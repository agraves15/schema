require 'bcrypt'

class User < ApplicationRecord
  validates :name, :email, :password_hash, presence: true
  validates :name, :email, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  has_many :schemes_users, dependent: :destroy
  has_many :schemes, through: :schemes_users
  has_friendship

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    password = Password.create(new_password)
    self.password_hash = password
  end
end
