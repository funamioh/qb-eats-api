class CreateDeliveryStaffs < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_staffs do |t|
      t.string :name
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
