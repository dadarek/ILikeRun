
class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :salt

  validates :user_name, :password, :salt, presence: true
  validates :user_name, uniqueness: {case_sensitive: false}

  before_save :encrypt_password

  def encrypt_password
    self.password = BCrypt::Engine.hash_secret(self.password, self.salt)
  end

end

