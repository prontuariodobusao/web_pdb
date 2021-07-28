class OrderManagerResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :created_at
        string :reference
        string :description
        object :owner do
          integer :id
          boolean :confirmation
          string :employee_name
          string :username
          string :occupation
        end
        object :problem do
          integer :id
          string :description
          string :priority
          object :category do
            integer :id
            string :name
          end
        end
        object :solution do
          integer :id
          string :description
        end
        object :manager do
          integer :id
          string :name
        end
        object :car_mecanic do
          integer :id
          string :name
        end
        object :status do
          integer :id
          string :color
          string :name
        end
        object :vehicle do
          integer :id
          string :car_number
        end
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
