class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :venue, null: false, foreign_key: true
      t.datetime :from
      t.datetime :to
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
