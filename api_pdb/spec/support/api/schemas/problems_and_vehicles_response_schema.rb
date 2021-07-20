class ProblemsAndVehiclesResponse
  include JSON::SchemaBuilder

  def schema
    object do
      array :vehicles do
        items do
          object do
            integer :id
            string :car_number
          end
        end
      end
      array :problems do
        items do
          object do
            integer :id
            string :description
          end
        end
      end
    end
  end
end
