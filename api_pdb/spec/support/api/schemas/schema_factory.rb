module SchemaFactory
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
