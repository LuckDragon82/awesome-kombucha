require 'pusher'

# Sandbox values for testing
Pusher.app_id = '122312'
Pusher.key = 'c26a1c6331c861eb0b91'
Pusher.secret = '65df568df1bb0a23f14c'


namespace :fake do
  desc "make the provided user an admin"
  task :sales do
    while true do
      begin
        Pusher.trigger('sales_channel', 'an_event', {name: Faker::Name.name, country: Faker::Address.country, quantity: rand(100)})
      rescue Pusher::Error => e
        puts "An error occrured while trying to push a new event #{error}"
      end
      sleep 5
    end
  end
end
