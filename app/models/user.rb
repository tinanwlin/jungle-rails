class User < ActiveRecord::Base
  has_secure_password
  validates :firstname, :lastname, :email, :password, presence: true
  validates :email, uniqueness: true
end
