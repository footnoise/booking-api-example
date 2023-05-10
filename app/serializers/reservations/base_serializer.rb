class Reservations::BaseSerializer < ActiveModel::Serializer
  belongs_to :guest
  
  attributes :id, :code, :start_date, :end_date, :nights, :guests, :adults, :children, :infants
  attributes :status, :currency, :payout_price, :security_price, :total_price
  attributes :created_at, :updated_at, :original_json
end