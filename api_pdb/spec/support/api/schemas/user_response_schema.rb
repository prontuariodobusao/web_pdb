class UserResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :identity
        string :name
        boolean :unlocked?
        boolean :confirmed?
      end
    end
  end
end
