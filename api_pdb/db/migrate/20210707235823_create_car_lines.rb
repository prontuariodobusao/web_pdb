class CreateCarLines < ActiveRecord::Migration[6.1]
  def change
    create_table :car_lines do |t|
      t.string :name, null: false
      t.integer :line_type, null: false
    end
  end
end
