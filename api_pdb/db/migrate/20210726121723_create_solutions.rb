class CreateSolutions < ActiveRecord::Migration[6.1]
  def change
    create_table :solutions do |t|
      t.string :description
      t.belongs_to :problem, null: false, foreign_key: true
    end
  end
end
