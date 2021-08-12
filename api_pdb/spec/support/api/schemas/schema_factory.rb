module SchemaFactory
  def resources_response_schema
    ResourcesResponse.new
  end

  def order_response_schema
    OrderResponse.new
  end

  def employee_response_schema
    EmployeeResponse.new
  end
  
  def create_employee_response_schema
    CreateEmployeeResponse.new
  end
  
  def create_user_response_schema
    CreateUserResponse.new
  end
  
  def employees_response_schema
    EmployeesResponse.new
  end

  def order_manager_response_schema
    OrderManagerResponse.new
  end

  def orders_response_schema
    OrdersResponse.new
  end

  def list_orders_openeds_and_closeds_response_schema
    ListOrdersOpenedsAndClosedsResponse.new
  end

  def problems_and_vehicles_response_schema
    ProblemsAndVehiclesResponse.new
  end

  def problems_response_schema
    ProblemsResponse.new
  end

  def users_response_schema
    UsersResponse.new
  end

  def user_response_schema
    UserResponse.new
  end

  def new_paginate_response_schema(response_schema)
    Paginations::OnlyPageSchema.new(response_schema)
  end

  def new_paginations_response_schema(response_schema)
    Paginations::PaginationsSchema.new(response_schema)
  end

  def new_middle_paginations_response_schema(response_schema)
    Paginations::MiddlePaginationsSchema.new(response_schema)
  end

  def new_errors_response
    Errors::ErrorsSchema.new
  end

  def new_errors_validations_response
    Errors::ErrorsValidationsSchema.new
  end
end
