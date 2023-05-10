module Reservations
  class Booking < Base
    # INFO: Validates that json is correct and cab be parsed as related object.
    def self.valid_reservation?(json_request)
      json_request[:reservation].present?
    end

    # INFO: Just mapping Reservation fields in the way:
    # reservation.attribute -> json[:attribute_name]
    def self.reservation_fields_mapping
      {
        code: %i(reservation code),
        start_date: %i(reservation start_date),
        end_date: %i(reservation end_date),
        nights: %i(reservation nights),
        guests: %i(reservation number_of_guests),
        adults: %i(reservation guest_details number_of_adults),
        children: %i(reservation guest_details number_of_children),
        infants: %i(reservation guest_details number_of_infants),
        status: %i(reservation status_type),
        currency: %i(reservation host_currency),
        payout_price_in_dollars: %i(reservation expected_payout_amount),
        security_price_in_dollars: %i(reservation listing_security_price_accurate),
        total_price_in_dollars: %i(reservation total_paid_amount_accurate)
      }
    end

    # INFO: Just mapping Guest fields in the way:
    # guest.attribute -> json[:guest_attribute_name]
    def self.guest_fields_mapping
      {
        email:         %i(reservation guest_email),
        first_name:    %i(reservation guest_first_name),
        last_name:     %i(reservation guest_last_name),
        phone_numbers: %i(reservation guest_phone_numbers)
      }
    end
  end
end