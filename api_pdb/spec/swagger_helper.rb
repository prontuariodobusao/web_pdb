# frozen_string_literal: true

require 'rails_helper'
require 'json/schema_builder'

# this block ensures if any schema element is extra or missing, the test fails.
JSON::SchemaBuilder.configure do |opts|
  opts.validate_schema = true
  opts.strict = true
end

RSpec.configure do |config|
  include SchemaFactory
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API Prontuário do Busão',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          Authorization: {
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        },
        schemas: {
          errors_message: {
            type: :object,
            properties: {
              message: { type: :string }
            }
          },
          errors_object: {
            type: :object,
            properties: {
              errors: { '$ref' => '#/components/schemas/errors_map' }
            }
          },
          errors_map: {
            type: :array,
            items: {
              type: :object,
              properties: {
                title: { type: :string },
                status: { type: :string },
                details: { type: :string }
              }
            }
          },
          confirmation_params: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  password: { type: :string },
                  password_confirmation: { type: :string }
                }
              }
            }
          },
          user_params: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  identity: { type: :string },
                  password: { type: :string },
                  password_confirmation: { type: :string }
                }
              }
            }
          },
          employee_params: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  name: { type: :string },
                  identity: { type: :string },
                  occupation_id: { type: :integer },
                  is_user: { type: :boolean }
                }
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'http://localhost:3003',
          variables: {
            defaultHost: {
              default: 'localhost:3003'
            }
          }
        },
        {
          url: 'https://apipdb.herokuapp.com',
          variables: {
            defaultHost: {
              default: 'apipdb.herokuapp.com'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
