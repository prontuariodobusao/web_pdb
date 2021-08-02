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
    end
  end
end
