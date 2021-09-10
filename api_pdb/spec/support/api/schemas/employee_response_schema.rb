class EmployeeResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :name
        string :confirmation
        string :identity
        string :occupation
        integer :occupation_id
        object :user do
          integer :id
          boolean :confirmation
          string :employee_name
          string :occupation
          string :username
          array :roles do
            items do
              object do
                integer :id
                string :name
              end
            end
          end
        end
      end
      object :meta do
        object :links do
          string :self
        end
      end
    end
  end
end
