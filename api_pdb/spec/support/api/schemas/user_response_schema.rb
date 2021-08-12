class UserResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :username
        string :employee_name
        string :occupation
        boolean :confirmation
      end
      object :meta do
        object :links do
          string :self
        end
      end
    end
  end
end
