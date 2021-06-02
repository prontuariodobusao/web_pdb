class UserResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        string :id
        string :type
        object :attributes do
          string :name
          string :email
          string :username
          string :type
        end
        object :links do
          string :self
        end
      end
    end
  end
end
