class UserResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :username
        string :employee_name
        boolean :confirmation
      end
    end
  end
end
