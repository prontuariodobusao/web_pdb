class AddColumnsToVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :vehicles, :km, :integer
    add_column :vehicles, :oil_date, :datetime
    add_column :vehicles, :tire_date, :datetime
    add_column :vehicles, :revision_date, :datetime
  end
end
