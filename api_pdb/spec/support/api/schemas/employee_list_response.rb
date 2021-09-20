class EmployeeListResponse
  include JSON::SchemaBuilder

  def schema
    array do
      items do
        object do
          integer :id
          string :name
        end
      end
    end
  end
end
