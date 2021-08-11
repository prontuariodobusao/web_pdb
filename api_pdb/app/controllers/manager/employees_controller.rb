module Manager
  class EmployeesController < ApplicationController
    before_action :set_employee, only: %i[show update]
    before_action :autorize_manager_or_rh

    # GET /manager/employees
    def index
      employees = Employee.page(current_page).per_page(per_page)

      options = pagination_meta_generator(request, employees.total_pages)

      json_response serializer_blueprint(:employee, employees, meta: options)
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
      @employee.update!(employee_params)
      head :no_content
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
  end
end
