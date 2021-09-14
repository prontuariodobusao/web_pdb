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
          array :roles do
            items do
              object do
                integer :id
                string :name
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
      string :password
    end
  end
end
