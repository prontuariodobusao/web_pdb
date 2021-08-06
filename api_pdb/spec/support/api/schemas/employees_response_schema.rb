class EmployeesResponse
  include JSON::SchemaBuilder

  def schema
    array do
      items do
        object :data do
          integer :id
          string :name
          string :identity
          string :occupation
        end
      end
    end
  end
end
