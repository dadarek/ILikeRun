class RunLog < ActiveRecord::Base
  attr_accessible :time_ran, :user_id, :date_ran
  validates :time_ran, numericality: {greater_than_or_equal_to: 1}
 # validates_inclusion_of :date_ran, in: Date.civil(2000, 1, 1)..Date.today, message: "must be between January 1, 2000 and today."
end
