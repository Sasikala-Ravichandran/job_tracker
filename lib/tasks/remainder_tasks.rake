desc 'send remainder email'

task send_remainder_email: :environment do
  Position.remainding_mail
end