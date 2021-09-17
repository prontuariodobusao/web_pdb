require 'swagger_helper'

describe 'Manager::Charts', type: :request do
  include_context 'create orders histories'

  let(:driver) { create(:driver_employee) }
  let(:mecanic) { create(:mecanic_employee) }

  let(:chart_report_params) do
    {
      data: {
        type_report: Faker::Number.within(range: 1..3),
        initial_date: (Date.current - 30.days).strftime('%d/%m/%Y'),
        end_date: Date.current.strftime('%d/%m/%Y')
      }
    }
  end
  let(:chart_mecanic_report_params) do
    {
      data: {
        initial_date: (Date.current - 30.days).strftime('%d/%m/%Y'),
        end_date: Date.current.strftime('%d/%m/%Y')
      }
    }
  end

  let(:chart_driver_problems_report_params) do
    {
      data: {
        initial_date: (Date.current - 30.days).strftime('%d/%m/%Y'),
        end_date: Date.current.strftime('%d/%m/%Y'),
        employee_id: driver.id,
        employee_type: 'driver'
      }
    }
  end

  let(:chart_mecanic_problems_report_params) do
    {
      data: {
        initial_date: (Date.current - 30.days).strftime('%d/%m/%Y'),
        end_date: Date.current.strftime('%d/%m/%Y'),
        employee_id: mecanic.id,
        employee_type: 'mecanic'
      }
    }
  end

  path '/manager/charts/report' do
    get 'Obter dados para gráficos' do
      tags 'Gráficos'
      description 'Rota para obtenção de dados para gráficos, essa pode ser executada por usuários autenticados'
      security [Authorization: []]
      produces 'application/json'

      response '200', 'Sucesso' do
        schema charts_report_response_schema.schema.as_json
        let(:Authorization) { authenticate_manager_user[:Authorization] }

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { charts_report_response_schema }
        end
      end

      include_context 'with errors response test'

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        run_test!
      end
    end
  end

  path '/manager/charts/report_by_dates' do
    post 'Obter dados para gráficos por datas' do
      tags 'Gráficos'
      description 'Rota para obtenção de dados para gráficos por datas, essa pode ser executada por usuários autenticados'
      security [Authorization: []]
      produces 'application/json'
      consumes 'application/json'

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/charts_report_params' }

      response '200', 'Sucesso' do
        schema charts_report_by_dates_response_schema.schema.as_json
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { chart_report_params }

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { charts_report_by_dates_response_schema }
        end
      end

      response '403', 'Acesso negado - Token inválido' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        schema new_errors_response.schema.as_json
        let(:data) { chart_report_params }

        it_behaves_like 'a error json endpoint', 403 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Access Denied - Invalid Token' }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:Accept) { 'application/foo' }
        let(:data) { chart_report_params }

        run_test!
      end

      response '422', 'Token não informado' do
        let(:Authorization) { nil }
        let(:data) { chart_report_params }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Missing Token' }
        end
      end

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { chart_report_params }
        run_test!
      end
    end
  end

  path '/manager/charts/report_mecanic_by_dates' do
    post 'Obter dados para gráficos de macânicos por ordens em manutenção e finalizadas por datas' do
      tags 'Gráficos'
      description 'Rota para obtenção de dados para gráficos por datas, essa pode ser executada por usuários autenticados'
      security [Authorization: []]
      produces 'application/json'
      consumes 'application/json'

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/charts_mecanic_report_params' }

      response '200', 'Sucesso' do
        schema charts_mecanic_report_by_dates_response_schema.schema.as_json
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { chart_mecanic_report_params }

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { charts_mecanic_report_by_dates_response_schema }
        end
      end

      response '403', 'Acesso negado - Token inválido' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        schema new_errors_response.schema.as_json
        let(:data) { chart_mecanic_report_params }

        it_behaves_like 'a error json endpoint', 403 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Access Denied - Invalid Token' }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:Accept) { 'application/foo' }
        let(:data) { chart_mecanic_report_params }

        run_test!
      end

      response '422', 'Token não informado' do
        let(:Authorization) { nil }
        let(:data) { chart_mecanic_report_params }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Missing Token' }
        end
      end

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { chart_mecanic_report_params }
        run_test!
      end
    end
  end

  path '/manager/charts/report_employee_problems_by_dates' do
    post 'Obter dados para gráfico de mecânico por problemas ou motorista por problemas' do
      tags 'Gráficos'
      description 'Rota para obtenção de dados para gráficos por funcionário e datas, essa pode ser executada por usuários autenticados'
      security [Authorization: []]
      produces 'application/json'
      consumes 'application/json'

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/charts_employee_problems_report_params' }

      context 'employee driver' do
        response '200', 'Sucesso' do
          schema charts_report_by_dates_response_schema.schema.as_json
          let(:Authorization) { authenticate_manager_user[:Authorization] }
          let(:data) { chart_driver_problems_report_params }

          it_behaves_like 'a json endpoint response', 200 do
            let(:expected_response_schema) { charts_report_by_dates_response_schema }
          end
        end
      end

      context 'employee mecanic' do
        response '200', 'Sucesso' do
          schema charts_report_by_dates_response_schema.schema.as_json
          let(:Authorization) { authenticate_manager_user[:Authorization] }
          let(:data) { chart_driver_problems_report_params }

          it_behaves_like 'a json endpoint response', 200 do
            let(:expected_response_schema) { charts_report_by_dates_response_schema }
          end
        end
      end

      response '403', 'Acesso negado - Token inválido' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        schema new_errors_response.schema.as_json
        let(:data) { chart_report_params }

        it_behaves_like 'a error json endpoint', 403 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Access Denied - Invalid Token' }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:Accept) { 'application/foo' }
        let(:data) { chart_report_params }

        run_test!
      end

      response '422', 'Token não informado' do
        let(:Authorization) { nil }
        let(:data) { chart_report_params }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Missing Token' }
        end
      end

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { chart_report_params }
        run_test!
      end
    end
  end
end
