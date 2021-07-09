class OrderResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        integer :km
        integer :vehicle_id
        integer :problem_id
      end
    end
  end
end
