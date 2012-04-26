class RunLog < ActiveRecord::Base
  attr_accessible :time_ran, :user_id, :created_at
  validates :time_ran, numericality: {greater_than_or_equal_to: 1}
  validates :created_at, presence: true
end
