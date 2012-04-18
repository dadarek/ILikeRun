
class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :salt

  validates :user_name, :password, :salt, presence: true
  validates :user_name, uniqueness: {case_sensitive: false}

  before_save :encrypt_password

  def encrypt_password
    self.password = BCrypt::Engine.hash_secret(self.password, self.salt)
  end

  def self.authenticate user_name, password
    user = find_by_user_name user_name
    #if not user.nil?
      hashed_password = hash_secret(password, user.salt)
      user if hashed_password == user.password
    #end
  end

  private

  def self.hash_secret(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

end

