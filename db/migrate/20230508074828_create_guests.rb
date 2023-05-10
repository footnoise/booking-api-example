class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :phone_numbers, default: '[]'

      t.timestamps
    end

    add_index :guests, :email, unique: true
  end
end
