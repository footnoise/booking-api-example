require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "POST #create" do
    context "when valid Booking JSON is received" do
      let(:valid_json) do
        {
          reservation: {
            code: "BOOK123",
            start_date: "2023-05-15",
            end_date: "2023-05-17",
            nights: 2,
            number_of_guests: 2,
            guest_details: {
              localized_description: "2 guests",
              number_of_adults: 2,
              number_of_children: 0,
              number_of_infants: 0
            },
            status_type: "accepted",
            host_currency: "AUD",
            expected_payout_amount: 200.0,
            listing_security_price_accurate: 50.0,
            total_paid_amount_accurate: 250.0,
            guest_email: "guest@booking.com",
            guest_first_name: "John",
            guest_last_name: "Doe",
            guest_phone_numbers: ["1234567890", "0987654321"]
          }
        }
      end
      
      subject do 
        post :create, body: valid_json.to_json, format: :json
        reservation_response = JSON.parse(response.body, symbolize_names: true)
        reservation_response["reservations/booking".to_sym]
      end
      
      it "returns HTTP success status" do
        subject
        expect(response).to have_http_status(:ok)
      end
      
      it 'returns created reservation in JSON format' do
        expect(subject.dig(:code)).to eq "BOOK123"
        expect(subject.dig(:start_date)).to eq "2023-05-15"
        expect(subject.dig(:end_date)).to eq "2023-05-17"
        expect(subject.dig(:nights)).to eq 2
        expect(subject.dig(:guests)).to eq 2
        expect(subject.dig(:adults)).to eq 2
        expect(subject.dig(:children)).to eq 0
        expect(subject.dig(:infants)).to eq 0
        expect(subject.dig(:status)).to eq "accepted"
        expect(subject.dig(:currency)).to eq "AUD"
        expect(subject.dig(:payout_price)).to eq 20000
        expect(subject.dig(:security_price)).to eq 5000
        expect(subject.dig(:total_price)).to eq 25000
        expect(subject.dig(:guest, :email)).to eq "guest@booking.com"
        expect(subject.dig(:guest, :first_name)).to eq "John"
        expect(subject.dig(:guest, :last_name)).to eq "Doe"
        expect(subject.dig(:guest, :phone_numbers)).to eq ["1234567890", "0987654321"]
      end
    end

    context "when valid Airbnb JSON is received" do
      let(:valid_json) do
        {
          reservation_code: "AIR123",
          start_date: "2023-05-15",
          end_date: "2023-05-17",
          nights: 2,
          guests: 2,
          adults: 2,
          children: 0,
          infants: 0,
          status: "accepted",
          currency: "AUD",
          payout_price: 200.0,
          security_price: 50.0,
          total_price: 250.0,
          guest: {
            email: "guest@airbnb.com",
            first_name: "John",
            last_name: "Doe",
            phone: "1234567890"
          }
        }
      end
      
      subject do 
        post :create, body: valid_json.to_json, format: :json
        reservation_response = JSON.parse(response.body, symbolize_names: true)
        reservation_response["reservations/airbnb".to_sym]
      end
      
      it "returns HTTP success status" do
        subject
        expect(response).to have_http_status(:ok)
      end
      
      it 'returns created reservation in JSON format' do
        expect(subject.dig(:code)).to eq "AIR123"
        expect(subject.dig(:start_date)).to eq "2023-05-15"
        expect(subject.dig(:end_date)).to eq "2023-05-17"
        expect(subject.dig(:nights)).to eq 2
        expect(subject.dig(:guests)).to eq 2
        expect(subject.dig(:adults)).to eq 2
        expect(subject.dig(:children)).to eq 0
        expect(subject.dig(:infants)).to eq 0
        expect(subject.dig(:status)).to eq "accepted"
        expect(subject.dig(:currency)).to eq "AUD"
        expect(subject.dig(:payout_price)).to eq 20000
        expect(subject.dig(:security_price)).to eq 5000
        expect(subject.dig(:total_price)).to eq 25000
        expect(subject.dig(:guest, :email)).to eq "guest@airbnb.com"
        expect(subject.dig(:guest, :first_name)).to eq "John"
        expect(subject.dig(:guest, :last_name)).to eq "Doe"
        expect(subject.dig(:guest, :phone_numbers)).to eq ["1234567890"]
      end
    end

    context "when invalid JSON request is received" do
      let(:invalid_json) { "invalid json" }
      
      it "returns HTTP not acceptable status and error message in JSON format" do
        post :create, body: invalid_json, format: :json
        expect(response).to have_http_status(:not_acceptable)
        
        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to be_present
        expect(error_response[:request]).to eq(invalid_json)
      end
    end
  end
  
  describe "PUT #update" do
    context "when valid Booking JSON request is received" do
      let(:reservation) { create(:reservation_booking) }
      let(:updated_attributes) { { status: "canceled" } }
      let(:valid_json) do
        {
          reservation: {
            code: reservation.code,
            start_date: reservation.start_date,
            end_date: reservation.end_date,
            nights: reservation.nights,
            number_of_guests: reservation.guests,
            guest_details: {
              localized_description: "2 guests",
              number_of_adults: reservation.adults,
              number_of_children: reservation.children,
              number_of_infants: reservation.infants
            },
            status_type: updated_attributes[:status],
            host_currency: reservation.currency,
            expected_payout_amount: reservation.payout_price_in_dollars,
            listing_security_price_accurate: reservation.security_price_in_dollars,
            total_paid_amount_accurate: reservation.total_price_in_dollars,
            guest_email: reservation.guest.email,
            guest_first_name: reservation.guest.first_name,
            guest_last_name: reservation.guest.last_name,
            guest_phone_numbers: reservation.guest.phone_numbers
          }
        }
      end
      
      subject do 
        put :update, body: valid_json.to_json, format: :json
        reservation_response = JSON.parse(response.body, symbolize_names: true)
        reservation_response['reservations/booking'.to_sym]
      end
      
      it "returns HTTP success status" do
        subject
        expect(response).to have_http_status(:ok)
      end
      
      it 'returns created reservation in JSON format' do
        expect(subject.dig(:code)).to eq reservation.code
        expect(subject.dig(:start_date)).to eq reservation.start_date.to_s
        expect(subject.dig(:end_date)).to eq reservation.end_date.to_s
        expect(subject.dig(:nights)).to eq reservation.nights
        expect(subject.dig(:guests)).to eq reservation.guests
        expect(subject.dig(:adults)).to eq reservation.adults
        expect(subject.dig(:children)).to eq reservation.children
        expect(subject.dig(:infants)).to eq reservation.infants
        expect(subject.dig(:status)).to eq updated_attributes[:status]
        expect(subject.dig(:currency)).to eq reservation.currency
        expect(subject.dig(:payout_price)).to eq reservation.payout_price
        expect(subject.dig(:security_price)).to eq reservation.security_price
        expect(subject.dig(:total_price)).to eq reservation.total_price
        expect(subject.dig(:guest, :email)).to eq reservation.guest.email
        expect(subject.dig(:guest, :first_name)).to eq reservation.guest.first_name
        expect(subject.dig(:guest, :last_name)).to eq reservation.guest.last_name
        expect(subject.dig(:guest, :phone_numbers)).to eq reservation.guest.phone_numbers
      end
    end

    context "when valid Airbnb JSON request is received" do
      let(:reservation) { create(:reservation_airbnb) }
      let(:updated_attributes) { { status: "canceled" } }
      let(:valid_json) do
        {
          reservation_code: reservation.code,
          start_date: reservation.start_date,
          end_date: reservation.end_date,
          nights: reservation.nights,
          guests: reservation.guests,
          adults: reservation.adults,
          children: reservation.children,
          infants: reservation.infants,
          status: updated_attributes[:status],
          currency: reservation.currency,
          payout_price: reservation.payout_price_in_dollars,
          security_price: reservation.security_price_in_dollars,
          total_price: reservation.total_price_in_dollars,
          guest: {
            email: reservation.guest.email,
            first_name: reservation.guest.first_name,
            last_name: reservation.guest.last_name,
            phone: reservation.guest.phone_numbers.first
          }
        }
      end
      
      subject do 
        put :update, body: valid_json.to_json, format: :json
        reservation_response = JSON.parse(response.body, symbolize_names: true)
        reservation_response["reservations/airbnb".to_sym]
      end
      
      it "returns HTTP success status" do
        subject
        expect(response).to have_http_status(:ok)
      end
      
      it "returns created reservation in JSON format" do
        expect(subject.dig(:code)).to eq reservation.code
        expect(subject.dig(:start_date)).to eq reservation.start_date.to_s
        expect(subject.dig(:end_date)).to eq reservation.end_date.to_s
        expect(subject.dig(:nights)).to eq reservation.nights
        expect(subject.dig(:guests)).to eq reservation.guests
        expect(subject.dig(:adults)).to eq reservation.adults
        expect(subject.dig(:children)).to eq reservation.children
        expect(subject.dig(:infants)).to eq reservation.infants
        expect(subject.dig(:status)).to eq updated_attributes[:status]
        expect(subject.dig(:currency)).to eq reservation.currency
        expect(subject.dig(:payout_price)).to eq reservation.payout_price
        expect(subject.dig(:security_price)).to eq reservation.security_price
        expect(subject.dig(:total_price)).to eq reservation.total_price
        expect(subject.dig(:guest, :email)).to eq reservation.guest.email
        expect(subject.dig(:guest, :first_name)).to eq reservation.guest.first_name
        expect(subject.dig(:guest, :last_name)).to eq reservation.guest.last_name
        expect(subject.dig(:guest, :phone_numbers)).to eq reservation.guest.phone_numbers
      end
    end

    context "when invalid JSON request is received" do
      let(:invalid_json) { "invalid json" }
      
      it "returns HTTP not acceptable status and error message in JSON format" do
        put :update, body: invalid_json, format: :json
        expect(response).to have_http_status(:not_acceptable)
        
        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to be_present
        expect(error_response[:request]).to eq(invalid_json)
      end
    end
  end
end