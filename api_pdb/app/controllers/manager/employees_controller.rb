module Manager
  class EmployeesController < ApplicationController
    before_action :set_employee, only: %i[show update]
    before_action :autorize_manager_or_rh

    # GET /manager/employees
    def index
      employees = if params[:type_occupation].present?
                    Employee.select(:id, :name).by_occupation(params[:type_occupation])
                  else
                    Employee.select(:id, :name)
                  end
      json_response employees
    end

    def datatable
      @employees = Employee.includes(:occupation, user: :roles).order(:name)
      result_dt = datatable_render(@employees, params, field_search: 'name')
      json_response({ draw: params[:draw],
                      totalRecords: result_dt[:totalRecords],
                      data: EmployeeBlueprint.render_as_hash(result_dt[:result]) })
    end

    # GET /manager/employees/1
    def show
      json_response EmployeeBlueprint.render(@employee, root: :data, meta: { links: links(@employee) })
    end

    # POST /manager/employees
    def create
      result = Employees::CreateEmployeeUser.call(employee: Employee.new(employee_params))
      employee = result[:data][:employee]

      json_response({
                      employee: EmployeeBlueprint.render_as_hash(employee, root: :data,
                                                                           meta: { links: links(employee) }),
                      password: result[:data][:password]
                    }, :created)
    end

    # PATCH/PUT /manager/employees/1
    def update
      @employee.update!(employee_edit_params)
      json_response EmployeeBlueprint.render(@employee, root: :data, meta: { links: links(@employee) })
    end

    private

    def autorize_manager_or_rh
      authorize Employee, :admin_or_rh?
    end

    def links(employee)
      { self: manager_employee_url(employee) }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:data).permit(
        :name,
        :identity,
        :occupation_id,
        :is_user
      )
    end

    def employee_edit_params
      params.require(:data).permit(
        :name,
        :identity,
        :occupation_id
      )
    end
  end
end
