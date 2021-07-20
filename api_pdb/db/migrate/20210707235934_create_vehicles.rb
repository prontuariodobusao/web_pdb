class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :car_number, null: false
      t.belongs_to :car_line, null: false, foreign_key: true
    end
  end
end
