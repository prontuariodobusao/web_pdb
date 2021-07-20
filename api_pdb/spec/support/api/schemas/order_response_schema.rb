class OrderResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :car_number
        integer :category_id
        string :category_name
        string :created_at
        string :problem
        string :reference
        string :status
        integer :status_id
        string :employee_name
      end
      object :meta do
        object :links do
          string :self
          string :image_url
        end
      end
    end
  end
end
