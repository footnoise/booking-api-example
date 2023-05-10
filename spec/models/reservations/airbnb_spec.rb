require 'rails_helper'

RSpec.describe Reservations::Airbnb, type: :model do
  describe "associations" do
    it { should belong_to(:guest) }
  end

  describe "validations" do
    let!(:guest) { create(:reservation_airbnb) }
    
    it { should validate_uniqueness_of(:code) }
  end

  describe ".valid_reservation?" do
    context "when the reservation_code is present" do
      it "returns true" do
        json_request = { reservation_code: "ABC123" }
        expect(described_class.valid_reservation?(json_request)).to be true
      end
    end

    context "when the reservation_code is missing" do
      it "returns false" do
        json_request = { some_other_key: "some_value" }
        expect(described_class.valid_reservation?(json_request)).to be false
      end
    end
  end

  describe ".reservation_fields_mapping" do
    it "maps reservation attributes to JSON keys" do
      expect(described_class.reservation_fields_mapping).to eq({
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
      })
    end
  end

  describe ".guest_fields_mapping" do
    it "maps guest attributes to JSON keys" do
      expect(described_class.guest_fields_mapping).to eq({
        email: [:guest, :email],
        first_name: [:guest, :first_name],
        last_name: [:guest, :last_name],
        phone_numbers: [:guest, :phone]
      })
    end
  end
end
