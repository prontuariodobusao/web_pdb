module Errors
  class ErrorsValidationsSchema
    include JSON::SchemaBuilder

    def schema
      object do
        string :title
        string :status
        array :errors do
          items do
            object do
              string :resource
              string :field
              string :detail
            end
          end
        end
      end
    end
  end
end
