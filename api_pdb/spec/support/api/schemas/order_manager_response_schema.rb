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
        object :solution do
          integer :id
          string :description
        end
        object :manager do
          integer :id
          string :name
          string :identity
          string :confirmation
          string :occupation
          integer :occupation_id
          object :user do
            integer :id
            string :username
            string :employee_name
            string :occupation
            boolean :confirmation
            array :roles do
              items do
                object do
                  integer :id
                  string :name
                end
              end
            end
          end
        end
        object :car_mecanic do
          integer :id
          string :name
          string :identity
          string :occupation
          string :confirmation
          integer :occupation_id
          object :user do
            integer :id
            string :username
            string :employee_name
            string :occupation
            boolean :confirmation
            array :roles do
              items do
                object do
                  integer :id
                  string :name
                end
              end
            end
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
