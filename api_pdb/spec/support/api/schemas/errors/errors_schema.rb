module Errors
  class ErrorsSchema
    include JSON::SchemaBuilder

    def schema
      object do
        array :errors do
          items do
            object do
              string :title
              string :status
              string :details
            end
          end
        end
      end
    end
  end
end
