class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :salt

  validates :user_name, :password, :salt, presence: true
  validates :user_name, uniqueness: {case_sensitive: false}

end
