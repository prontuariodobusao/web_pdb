class VehicleResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        integer :car_line_id
        integer :km
        string :car_number
        string :oil_date
        string :tire_date
        string :revision_date
      end
      object :meta do
        object :links do
          string :self
        end
      end
    end
  end
end
