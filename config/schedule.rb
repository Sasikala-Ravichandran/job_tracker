env :PATH, ENV['PATH']

set :environment, "production"

set :output, "log/cron_log.log"

every :day, :at => '0:00 am' do
  rake 'send_remainder_email'
end