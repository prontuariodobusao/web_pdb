class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :identity, unique: true, null: false
      t.string :password_digest, null: false
      t.datetime :locked_at
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
