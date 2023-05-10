require 'rails_helper'

RSpec.describe Reservations::Booking do
  describe "associations" do
    it { should belong_to(:guest) }
  end

  describe "validations" do
    let!(:guest) { create(:reservation_booking) }
    
    it { should validate_uniqueness_of(:code) }
  end

  describe ".valid_reservation?" do
    context "when the json_request contains a reservation" do
      let(:json_request) { { reservation: { code: "ABC123"} } }

      it "returns true" do
        expect(described_class.valid_reservation?(json_request)).to be true
      end
    end

    context "when the json_request does not contain a reservation" do
      let(:json_request) { {} }

      it "returns false" do
        expect(described_class.valid_reservation?(json_request)).to be false
      end
    end
  end

  describe ".reservation_fields_mapping" do
    it "maps the reservation fields to the correct JSON keys" do
      expect(described_class.reservation_fields_mapping).to eq(
        {
          code: [:reservation, :code],
          start_date: [:reservation, :start_date],
          end_date: [:reservation, :end_date],
          nights: [:reservation, :nights],
          guests: [:reservation, :number_of_guests],
          adults: [:reservation, :guest_details, :number_of_adults],
          children: [:reservation, :guest_details, :number_of_children],
          infants: [:reservation, :guest_details, :number_of_infants],
          status: [:reservation, :status_type],
          currency: [:reservation, :host_currency],
          payout_price_in_dollars: [:reservation, :expected_payout_amount],
          security_price_in_dollars: [:reservation, :listing_security_price_accurate],
          total_price_in_dollars: [:reservation, :total_paid_amount_accurate]
        }
      )
    end
  end

  describe ".guest_fields_mapping" do
    it "maps the guest fields to the correct JSON keys" do
      expect(described_class.guest_fields_mapping).to eq(
        {
          email: [:reservation, :guest_email],
          first_name: [:reservation, :guest_first_name],
          last_name: [:reservation, :guest_last_name],
          phone_numbers: [:reservation, :guest_phone_numbers]
        }
      )
    end
  end
end
