class VehicleBlueprint < Blueprinter::Base
  identifier :id

  fields :car_number,
         :km,
         :car_line_id,
         :oil_date,
         :tire_date,
         :revision_date
end
