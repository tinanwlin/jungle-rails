class User < ActiveRecord::Base
  before_save { self.email = email.downcase } 
  has_many :orders
  
  has_secure_password

  validates :password, length: { minimum: 3 }
  validates :firstname, :lastname, :email, :password, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials email, password
        email.strip!
        email.downcase!
      if user = User.find_by(email: email).try(:authenticate, password)
        user
      else
        nil
      end
    end

end
