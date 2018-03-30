class User < ActiveRecord::Base
  before_save {self.email = email.downcase } 
  has_many :orders
  
  has_secure_password

  validates :firstname, :lastname, :email, :password, presence: true
  validates :email, uniqueness: true
end
