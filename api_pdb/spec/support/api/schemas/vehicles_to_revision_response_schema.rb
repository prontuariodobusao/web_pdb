class VehiclesToRevisionResponse
  include JSON::SchemaBuilder

  def schema
    object do
      array :vehicles_to_oil_change do
        items do
          object do
            integer :id
            string :name
            integer :current_km
          end
        end
      end
      array :vehicles_to_tire_change do
        items do
          object do
            integer :id
            string :name
            integer :current_km
          end
        end
      end
      array :vehicles_to_revision_change do
        items do
          object do
            integer :id
            string :name
            integer :current_km
          end
        end
      end
    end
  end
end
