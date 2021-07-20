class CreateProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :problems do |t|
      t.string :description
      t.string :solution
      t.integer :priority, null: false
      t.belongs_to :category, null: false, foreign_key: true
    end
  end
end
