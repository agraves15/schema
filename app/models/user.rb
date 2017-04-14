require 'bcrypt'

class User < ActiveRecord::Base
  validates :name, :email, :password_hash, presence: true
  validates :name, :email, uniqueness: true
  has_many :friends, class_name: 'User'
  has_many :schemes_users, dependent: :destroy
  has_many :schemes, through: :schemes_users

  include BCrypt

  def password
    # modify the password method to be able to handle a nil password_hash
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
