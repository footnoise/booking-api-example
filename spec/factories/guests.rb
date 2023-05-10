FactoryBot.define do
  factory :guest do
    sequence(:email) { |n| "guest#{n}@example.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_numbers { [{ number: Faker::PhoneNumber.cell_phone }] }
  end
end
