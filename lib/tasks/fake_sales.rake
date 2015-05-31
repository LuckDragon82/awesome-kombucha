require 'pusher'

# Sandbox values for testing

namespace :fake do
  desc "make the provided user an admin"
  task :sales => :environment do
    while true do
      begin
        if (rand(10) < 7)
          order = Order.create({first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: "#{Faker::Address.street_address} #{Faker::Address.city}, #{Faker::Address.state_abbr} #{Faker::Address.postcode}", quantity: rand(100), country: Faker::Address.country, credit_card_number: Faker::Business.credit_card_number, credit_card_code: Faker::Number.number(3), credit_card_date: '11/25'})
          puts "Order Created: #{order.to_json}"
        else
          order = Order.where.not(status: 'shipped').first
          order.status = 'shipped' if order
          order.save if order
          puts "Order Shipped #{order.to_json}" if order
        end
      rescue => error
        puts "An error occrured while trying to create a new order #{error}"
      end
      sleep 5
    end
  end
end
