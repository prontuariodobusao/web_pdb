class OrderResponse
  include JSON::SchemaBuilder

  def schema
    object do
      object :data do
        integer :id
        string :created_at
        string :reference
        object :owner do
          integer :id
          boolean :confirmation
          string :employee_name
          string :username
          string :occupation
          array :roles do
            items do
              object do
                integer :id
                string :name
              end
            end
          end
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
        object :status do
          integer :id
          string :color
          string :name
        end
        object :vehicle do
          integer :id
          integer :km
          integer :car_line_id
          string :car_number
          string :oil_date
          string :tire_date
          string :revision_date
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
