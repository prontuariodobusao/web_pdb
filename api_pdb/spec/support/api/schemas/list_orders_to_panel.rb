class ListOrdersToPanelResponse
  include JSON::SchemaBuilder

  def schema
    object do
      array :data do
        items do
          object do
            integer :id
            string :reference
            string :category
            string :description
            string :status
            string :mecanic
            string :owner
          end
        end
      end
    end
  end
end
