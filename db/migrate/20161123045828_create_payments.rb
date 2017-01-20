class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer  :appointment_id
      t.string   :ip_address
      t.string   :first_name
      t.string   :last_name
      t.string   :card_type
      t.date     :card_expires_on	
      t.timestamps
    end
  end
end
