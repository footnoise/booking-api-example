FactoryBot.define do
  factory :reservation_booking, class: Reservations::Booking do
    sequence(:code) { |n| "BOOK#{n}" }
    start_date { 1.day.from_now.to_date }
    end_date { 3.days.from_now.to_date }
    nights { 2 }
    guests { 3 }
    adults { 2 }
    children { 1 }
    infants { 0 }
    status { "confirmed" }
    currency { "AUD" }
    payout_price_in_dollars { 200_00 }
    security_price_in_dollars { 50_00 }
    total_price_in_dollars { 250_00 }
    
    association :guest, factory: :guest
  end
  
  factory :reservation_airbnb, class: Reservations::Airbnb do
    sequence(:code) { |n| "AIR#{n}" }
    start_date { 1.day.from_now.to_date }
    end_date { 3.days.from_now.to_date }
    nights { 2 }
    guests { 3 }
    adults { 2 }
    children { 1 }
    infants { 0 }
    status { "confirmed" }
    currency { "AUD" }
    payout_price_in_dollars { 200_00 }
    security_price_in_dollars { 50_00 }
    total_price_in_dollars { 250_00 }
    
    association :guest, factory: :guest
  end
end
