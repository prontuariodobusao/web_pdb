class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :identity, null: false, unique: true
      t.belongs_to :occupation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
