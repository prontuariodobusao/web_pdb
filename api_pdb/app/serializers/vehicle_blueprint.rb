class VehicleBlueprint < Blueprinter::Base
  identifier :id

  fields :car_number,
         :km,
         :car_line_id
  field :oil_date, datetime_format: '%d/%m/%Y'
  field :tire_date, datetime_format: '%d/%m/%Y'
  field :revision_date, datetime_format: '%d/%m/%Y'
  field :break_predictability
end
