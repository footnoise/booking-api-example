module Reservations
  class Base < ApplicationRecord
    include ::Currency
    
    self.table_name = :reservations

    belongs_to :guest
    has_currency :payout_price, :security_price, :total_price
    
    validates :code, uniqueness: true
    validates :currency, inclusion: { in: ["AUD"] }

    def self.from_json(json)
      json_mapper = JsonMapper.new(json)

      email = json.dig(*guest_fields_mapping[:email])
      code = json.dig(*reservation_fields_mapping[:code]) 

      guest = json_mapper.do_mapping Guest.find_or_initialize_by(email: email), guest_fields_mapping
      reservation = find_or_initialize_by guest: guest, code: code
      reservation.original_json = json

      json_mapper.do_mapping reservation, reservation_fields_mapping
    end

    def self.valid_reservation?
      # TODO: put default code here
      raise NotImplementedError
    end

    def self.reservation_fields_mapping
      # TODO: put default code here
      raise NotImplementedError
    end
    
    def self.guest_fields_mapping
      # TODO: put default code here
      raise NotImplementedError
    end
  end
end
