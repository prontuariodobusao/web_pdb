class AddReferencesEmployeeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :employee, null: false, foreign_key: true
  end
end
