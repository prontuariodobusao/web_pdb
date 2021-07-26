class AddReferencesSolutionToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :solution, foreign_key: true
  end
end
