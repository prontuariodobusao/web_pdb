class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.string :km
      t.string :description
      t.belongs_to :status, null: false, foreign_key: true
      t.belongs_to :order, null: false, foreign_key: true
      t.references :owner, foreign_key: { to_table: :users }

      t.datetime :created_at
    end
  end
end
