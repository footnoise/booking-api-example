require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe "associations" do
    it { should have_many(:reservations) }
  end

  describe "validations" do
    let!(:guest) { create(:guest) }
    
    it { should validate_uniqueness_of(:email) }
  end

  describe "serialization" do
    context "when add single phone number" do
      it "serializes phone_numbers attribute to Array" do
        guest = Guest.create(email: "test@example.com", phone_numbers: "123-456-7890")
        expect(guest.phone_numbers).to eq(["123-456-7890"])
        expect(guest.phone_numbers.class).to eq(Array)
      end
    end

    context "when add multiples phone numbers" do
      it "serializes phone_numbers attribute to Array" do
        guest = Guest.create(email: "test@example.com", phone_numbers: ["123-456-7890", "987-654-3210"])
        expect(guest.phone_numbers).to eq(["123-456-7890", "987-654-3210"])
        expect(guest.phone_numbers.class).to eq(Array)
      end
    end
  end
end
