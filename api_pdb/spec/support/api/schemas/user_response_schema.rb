class UserResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :identity
        string :name
        boolean :confirmation
      end
    end
  end
end
