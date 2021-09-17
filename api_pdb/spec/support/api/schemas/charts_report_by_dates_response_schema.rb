class ChartsReportByDatesResponse
  include JSON::SchemaBuilder

  def schema
    object do
      array :report do
        items do
          object do
            string :name
            integer :y
          end
        end
      end
    end
  end
end
