class ListOrdersOpenedsAndClosedsResponse
  include JSON::SchemaBuilder

  def schema
    object do
      array :openeds do
        items do
          object do
            integer :id
            integer :category_id
            integer :status_id
            string :created_at
            string :reference
            string :status
          end
        end
      end
      array :closeds do
        items do
          object do
            integer :id
            integer :category_id
            integer :status_id
            string :created_at
            string :reference
            string :status
          end
        end
      end
    end
  end
end
