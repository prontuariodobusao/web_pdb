module Orders
  class NextNumber
    include UseCase

    def call
      next_number
    end

    private

    def next_number
      year = Date.current.strftime('%Y')
      last_number = Order.find_last_number_by_year

      return "OS_00001/#{year}" if last_number.nil?

      "OS_#{format('%05d', (last_number.split('_')[1].to_i + 1))}/#{year}"
    end
  end
end
