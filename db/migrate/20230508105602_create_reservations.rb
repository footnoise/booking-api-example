class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :type
      t.string :code, null: false
      t.references :guest
      t.date :start_date
      t.date :end_date
      t.string :status
      t.integer :payout_price
      t.integer :security_price
      t.integer :total_price
      t.string :currency,  default: :aud
      t.integer :nights,   default: 0
      t.integer :guests,   default: 0
      t.integer :adults,   default: 0
      t.integer :children, default: 0
      t.integer :infants,  default: 0
      t.text :original_json
      t.timestamps
    end

    add_index :reservations, :code, unique: true
  end
end
