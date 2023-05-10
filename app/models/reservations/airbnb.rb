module Reservations
  class Airbnb < Base
    # INFO: Validates that json is correct and cab be parsed as related object.
    def self.valid_reservation?(json_request)
      json_request[:reservation_code].present?
    end

    # INFO: Just mapping Reservation fields in the way:
    # reservation.attribute -> json[:attribute_name] 
    def self.reservation_fields_mapping
      {
        code: :reservation_code,
        start_date: :start_date,
        end_date: :end_date,
        nights: :nights,
        guests: :guests,
        adults: :adults,
        children: :children,
        infants: :infants,
        status: :status,
        currency: :currency,
        payout_price_in_dollars: :payout_price,
        security_price_in_dollars: :security_price,
        total_price_in_dollars: :total_price
      }
    end

    # INFO: Just mapping Guest fields in the way:
    # guest.attribute -> json[:guest_attribute_name]
    def self.guest_fields_mapping
      {
        email:         %i(guest email),
        first_name:    %i(guest first_name),
        last_name:     %i(guest last_name),
        phone_numbers: %i(guest phone)
      }
    end
  end
end