class ResourcesResponse
  include JSON::SchemaBuilder

  def schema
    object do
      array :solutions do
        items do
          object do
            integer :id
            string :description
          end
        end
      end
      array :statuses do
        items do
          object do
            integer :id
            string :name
            string :color
          end
        end
      end
      array :mecanics do
        items do
          object do
            integer :id
            string :name
          end
        end
      end
    end
  end
end
