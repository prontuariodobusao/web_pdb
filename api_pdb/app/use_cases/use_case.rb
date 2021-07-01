module UseCase
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  class_methods do
    # The perform method of a UseCase should always return itself
    def call(**kargs)
      new(**kargs).call
    end
  end

  # implement all the steps required to complete this use case
  def call
    raise NotImplementedError
  end

  def success(data)
    OpenStruct.new(success?: true, data: data, errors: nil)
  end

  def failure(errors)
    OpenStruct.new(success?: false, data: nil, errors: errors)
  end
end
