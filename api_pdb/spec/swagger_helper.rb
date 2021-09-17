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
  config.swagger_root = Rails.root.join('swagger').to_s
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
          },
          vehicle_params: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  car_number: { type: :string },
                  km: { type: :integer },
                  car_line_id: { type: :integer },
                  oil_date: { type: :string },
                  tire_date: { type: :string },
                  revision_date: { type: :string }
                }
              }
            }
          },
          datatable_params: {
            type: :object,
            properties: {
              draw: { type: :integer },
              page: { type: :integer },
              per_page: { type: :integer },
              sort_field: { type: :string },
              sort_direction: { type: :string },
              search_value: { type: :string }
            }
          },
          charts_report_params: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  type_report: { type: :integer },
                  initial_date: { type: :string },
                  end_date: { type: :string }
                }
              }
            }
          },
          charts_mecanic_report_params: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  initial_date: { type: :string },
                  end_date: { type: :string }
                }
              }
            }
          },
          charts_employee_problems_report_params: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  initial_date: { type: :string },
                  end_date: { type: :string },
                  employee_id: { type: :integer },
                  employee_type: { type: :string }
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
