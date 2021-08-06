module Manager
  class EmployeesController < ApplicationController
    before_action :set_employee, only: %i[show update destroy]
    before_action :autorize_manager_or_rh

    # GET /manager/employees
    def index
      @employees = Employee.all

      json_response EmployeeBlueprint.render @employees
    end

    # GET /manager/employees/1
    def show
      json_response EmployeeBlueprint.render @employee
    end

    # POST /manager/employees
    def create
      employee = Employee.new(employee_params)

      employee.save!

      json_response_create(EmployeeBlueprint.render(employee, root: :data, meta: { links: links(employee) }),
                           manager_employee_path(employee))
    end

    # PATCH/PUT /manager/employees/1
    def update
      @employee.update!(employee_params)
      head :no_content
    end

    # DELETE /manager/employees/1
    def destroy
      @employee.destroy!
      head :no_content
    end

    private

    def autorize_manager_or_rh
      authorize Employee, :manager_or_rh?
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
        :occupation_id
      )
    end
  end
end
