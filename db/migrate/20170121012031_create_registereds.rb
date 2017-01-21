class CreateRegistereds < ActiveRecord::Migration[5.0]
  def change
    create_table :registereds do |t|

      t.timestamps
    end
  end
end
