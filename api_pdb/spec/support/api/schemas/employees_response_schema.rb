class EmployeesResponse
  include JSON::SchemaBuilder

  def build_paginate(paginate)
    paginate.object do
      integer :id
      string :name
      string :confirmation
      string :identity
      string :occupation
      integer :occupation_id
      object :user do
        integer :id
        boolean :confirmation
        string :employee_name
        string :occupation
        string :username
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
  end

  def schema
    array do
      items do
        object :data do
          integer :id
          string :name
          string :identity
          string :occupation
        end
      end
    end
  end
end
