class Order < ApplicationRecord
  has_one_attached :image

  enum state: %i[opened closed]

  belongs_to :problem
  delegate :description, to: :problem, prefix: true
  delegate :category_id, to: :problem, prefix: true

  belongs_to :solution, optional: true
  delegate :description, to: :solution, prefix: true

  belongs_to :vehicle
  delegate :car_number, to: :vehicle, prefix: true

  belongs_to :status
  delegate :name, to: :status, prefix: true

  belongs_to :owner, class_name: 'User'
  belongs_to :manager, class_name: 'Employee', optional: true
  delegate :name, to: :manager, prefix: true
  belongs_to :car_mecanic, class_name: 'Employee', optional: true
  delegate :name, to: :manager, prefix: true

  has_many :histories

  validates_presence_of :km
  validates :reference, uniqueness: true, presence: true

  scope :by_user, lambda { |current_user, state|
    select(
      :id,
      :reference,
      :created_at,
      :status_id,
      :problem_id
    ).includes(:status, :problem).where(owner: current_user, state: state)
  }

  scope :to_managers, lambda { |state|
    select(
      :id,
      :reference,
      :created_at,
      :status_id,
      :problem_id
    ).includes(:status, :problem).where(state: state)
  }

  scope :waiting, -> { where(status_id: 1) }
  scope :maintenance, -> { where(status_id: 2) }
  scope :canceled, -> { where(status_id: 3) }
  scope :finish, -> { where(status_id: 4) }
  scope :maintenance_and_finish, -> { where(status_id: [2, 4]) }
  scope :by_mecanic, ->(mecanic_id) { where(car_mecanic_id: mecanic_id) }
  scope :by_categories, -> { OrdersQueries::OrdersByCategoryQuery.call }
  scope :by_problems, -> { OrdersQueries::OrdersByProblemQuery.call }
  scope :by_mecanics, -> { OrdersQueries::OrdersByMecanicQuery.call }
  scope :query_by_dates, lambda { |initial_date, end_date, type_report|
                           OrdersQueries::OrdersByDatesAndTypesQuery.call(
                             initial_date: initial_date,
                             end_date: end_date,
                             type_report: type_report
                           )
                         }
  scope :query_employee_problems_by_dates, lambda { |initial_date, end_date, employee_id, employee_type|
                                             OrdersQueries::OrdersByDatesEmployeeTypeQuery.call(
                                               initial_date: initial_date,
                                               end_date: end_date,
                                               employee_id: employee_id,
                                               employee_type: employee_type
                                             )
                                           }

  scope :query_mecanic_by_dates, lambda { |initial_date, end_date|
                                   OrdersQueries::OrdersMecanicByDatesQuery.call(
                                     initial_date: initial_date,
                                     end_date: end_date
                                   )
                                 }

  def image_url
    # get url path
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  def self.find_last_number_by_year
    result = Order
             .select(:reference)
             .where('orders.reference ILIKE ?', "%#{Date.current.strftime('%Y')}%")
             .order(reference: :desc)
             .take

    return result.reference unless result.nil?

    nil
  end
end
