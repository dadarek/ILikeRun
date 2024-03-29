
class User < ActiveRecord::Base
  attr_accessible :user_name, :password
  has_many :run_logs
  has_one :schedule

  validates :user_name, :password, :salt, presence: true
  validates :user_name, uniqueness: {case_sensitive: false}

  before_validation :generate_salt
  before_save :encrypt_password, :disallow_update, :create_schedule

  def generate_salt
    self.salt = BCrypt::Engine.generate_salt
  end

  def encrypt_password
    self.password = User.hash_secret(password, salt)
  end

  def disallow_update
    if not id.nil?
      throw :update_disallowed
    end
  end

  def create_schedule
    self.schedule = Schedule.create!(user_id: self.id)
  end

  def self.authenticate user_name, password
    user = find_by_user_name(user_name)
    if not user.nil?
      hashed_password = hash_secret(password, user.salt)
      user if hashed_password == user.password
    end
  end

  def self.find_by_user_name user_name
    if not user_name.nil?
      return User.where('lower(user_name) = ?', user_name.downcase).first
    end
  end

  private

  def self.hash_secret(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

end

