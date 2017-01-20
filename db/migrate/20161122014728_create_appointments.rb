class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.integer  :initiator_id
      t.integer  :receiver_id
      t.datetime :datetime
      t.float    :price
      t.string   :currency
      t.boolean  :paid

      t.timestamps
    end
  end
end
