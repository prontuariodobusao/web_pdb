class AddColumnsToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :admission_date, :date
    add_column :employees, :driver_license, :integer
  end
end
