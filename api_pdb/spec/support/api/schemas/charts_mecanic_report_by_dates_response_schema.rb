class ChartsMecanicReportByDatesResponse
  include JSON::SchemaBuilder

  def schema
    object do
      array :orders_maintenance do
        items do
          object do
            string :name
            integer :y
          end
        end
      end
      array :orders_finish do
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
