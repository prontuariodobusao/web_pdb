class EmployeeResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :name
        string :identity
        string :driver_license
        string :admission_date
        string :occupation
      end
      object :meta do
        object :links do
          string :self
        end
      end
    end
  end
end
