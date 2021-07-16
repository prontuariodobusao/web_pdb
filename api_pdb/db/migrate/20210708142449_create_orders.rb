class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :reference
      t.integer :km
      t.string :description, default: ''
      t.integer :state, default: 0
      t.belongs_to :problem, null: false, foreign_key: true
      t.belongs_to :vehicle, null: false, foreign_key: true
      t.belongs_to :status, null: false, foreign_key: true
      t.references :owner, foreign_key: { to_table: :users }
      t.references :manager, foreign_key: { to_table: :employees }
      t.references :car_mecanic, foreign_key: { to_table: :employees }

      t.timestamps
    end
  end
end
