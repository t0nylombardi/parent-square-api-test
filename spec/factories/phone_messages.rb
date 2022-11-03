FactoryBot.define do
  factory :phone_message do
    phone_number { Faker::PhoneNumber.phone_number }
    message { Faker::Lorem.sentences(number: 1) }
    invailid { false }
  end
end