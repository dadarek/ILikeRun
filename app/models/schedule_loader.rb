
class ScheduleLoader

  def self.load user
    if user.schedule.nil?
      Schedule.create! user_id: user.id
    end
  end

end
