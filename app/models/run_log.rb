class RunLog < ActiveRecord::Base
  attr_accessible :time_ran, :user_id
  validates :time_ran, numericality: {greater_than_or_equal_to: 1}
end
