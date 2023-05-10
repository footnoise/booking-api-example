class ReservationsManager
  @@supported_models = [
    ::Reservations::Airbnb,
    ::Reservations::Booking
    # TODO: Some potentials formats can be added here as well.
  ]

  def self.create_or_update(json_request)
    @@supported_models.each do |model|
      if model.valid_reservation?(json_request)
        new_reservation = model.from_json(json_request)
        new_reservation.save!
        return new_reservation
      end 
    end

    raise NotImplementedError.new('Unsupported Format')
  end
end