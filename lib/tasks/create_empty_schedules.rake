namespace :db do

  desc "Create an empty default schedule for existing users."
  task create_empty_schedules: :environment do
    User.all.each{ |user|
      ScheduleLoader.load user
    }
  end

end

