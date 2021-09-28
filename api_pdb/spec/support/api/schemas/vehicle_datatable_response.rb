class VehicleDatatableResponse
  include JSON::SchemaBuilder

  def schema
    object do
      integer :draw
      integer :totalRecords
      array :data do
        items do
          object do
            integer :id
            integer :car_line_id
            integer :km
            string :car_number
            string :oil_date
            string :tire_date
            string :revision_date
          end
        end
      end
    end
  end
end
