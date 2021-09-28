class ChartsReportResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :qtds do
        integer :total
        integer :os_waiting
        integer :os_maintenance
        integer :os_canceled
        integer :os_finish
        integer :os_down_time
      end
      array :categories do
        items do
          object do
            string :name
            integer :y
          end
        end
      end
      array :problems do
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
