class OrdersResponse
  include JSON::SchemaBuilder

  def schema
    array do
      items do
        object :data do
          integer :id
          integer :category_id
          string :created_at
          string :reference
          string :status
        end
      end
    end
  end
end
