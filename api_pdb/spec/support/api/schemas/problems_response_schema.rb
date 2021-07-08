class ProblemsResponse
  include JSON::SchemaBuilder

  def schema
    array do
      items do
        object do
          integer :id
          string :description
        end
      end
    end
  end
end
