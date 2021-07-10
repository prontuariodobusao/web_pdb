class OrderResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        integer :km
        integer :car_number
        string :problem
        string :state
        string :status
        string :description
      end
      object :meta do
        object :links do
          string :self
          string :image_url
        end
      end
    end
  end
end
