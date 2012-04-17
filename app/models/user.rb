class User < ActiveRecord::Base
  attr_accessible :user_name, :password, :salt

  validates :user_name, :password, :salt, presence: true

end
