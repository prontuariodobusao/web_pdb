class UsersResponse
  include JSON::SchemaBuilder

  def build_paginate(paginate)
    paginate.object do
      string :id
      string :type
      object :attributes do
        string :name
        string :type
      end
      object :links do
        string :self
      end
    end
  end

  def schema
    object do
      string :id
      string :type
      object :attributes do
        string :name
        string :type
      end
      object :links do
        string :self
      end
    end
  end
end
