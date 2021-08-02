class AddColumnTypeOccupationToOccupations < ActiveRecord::Migration[6.1]
  def change
    add_column :occupations, :type_occupation, :integer
  end
end
