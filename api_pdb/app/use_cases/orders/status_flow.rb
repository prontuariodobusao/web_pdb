module Orders
  class StatusFlow
    include UseCase

    def initialize(current_status:)
      @current_status = current_status
    end

    def call
      status_flow
    end

    private

    attr_accessor :current_status

    def status_flow
      case current_status
      when 1
        Status.where(id: [2, 3])
      when 2
        Status.where(id: [3, 4])
      else
        raise StandardError, 'Status not allowed'
      end
    end
  end
end
