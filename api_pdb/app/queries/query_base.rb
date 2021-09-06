module QueryBase
  extend ActiveSupport::Concern

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
end
