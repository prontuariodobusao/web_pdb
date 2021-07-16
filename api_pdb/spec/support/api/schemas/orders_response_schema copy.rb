class OrdersResponse
  include JSON::SchemaBuilder

  def schema
    array do
      items do
        object :data do
          integer :id
          string :reference
          integer :km
          string :car_number
          string :problem
          string :state
          string :status
          string :description
        end
      end
    end
  end
end
