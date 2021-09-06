class CreateUserResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :user do
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
      string :password
    end
  end
end
