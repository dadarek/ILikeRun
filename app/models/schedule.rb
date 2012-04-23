class Schedule < ActiveRecord::Base
  attr_accessible :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :user_id, :wednesday
end
