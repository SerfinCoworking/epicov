# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "log/cron.log"

# every 5.hours do
#   rake 'batch:update_lot_status'
# end

every 1.day, at: '11:30 pm' do
  rake "batch:save_case_count_per_days"
end

every 1.day, at: '12:30 am' do
  rake "batch:update_restored_positive_cases"
end
