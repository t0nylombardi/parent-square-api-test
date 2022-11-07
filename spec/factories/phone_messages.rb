FactoryBot.define do
  factory :phone_message do
    message_id { Faker::Internet.uuid }    
    phone_number { Faker::PhoneNumber.phone_number }
    message { Faker::Lorem.sentences(number: 1) }
    status { 'delivered' }
  end
end