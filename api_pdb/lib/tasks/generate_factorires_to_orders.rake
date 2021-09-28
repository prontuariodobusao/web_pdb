#!/usr/bin/env rake

namespace :orders do
  desc 'Generate factories to orders'
  task generate_factories_to_orders: [:environment] do
    vehicles = Vehicle.order(:id)
    orders = Order.order(:id)
    histories = History.order(:id)

    vehicles.each do |v|
      puts <<~HEREDOC
        let(:vehicle#{v.id}) do
          create(:vehicle, km: 5000, car_number: '#{v.car_number}', oil_date: '#{rand(30...60).days.ago.strftime('%d/%m/%Y')}', tire_date: '#{rand(30...60).days.ago.strftime('%d/%m/%Y')}', revision_date: '#{rand(30...60).days.ago.strftime('%d/%m/%Y')}')
        end
      HEREDOC
    end

    orders.each do |o|
      puts <<~HEREDOC
        let(:order#{o.id}) do
          create(:order, reference: '#{o.reference}', km: #{o.km}, state: #{o.state}, problem_id: #{o.problem_id}, vehicle_id: #{o.vehicle_id}, status_id: #{o.status_id}, created_at: '#{o.created_at.strftime('%d/%m/%Y')}', updated_at: '#{o.updated_at.strftime('%d/%m/%Y')}')
        end
      HEREDOC
    end
    
    histories.each do |h|
      puts <<~HEREDOC
        let(:history#{h.id}) do
          create(:history,
            km: #{h.km},
            description: '#{h.description}',
            status_id: status#{h.status_id}.id,
            order_id: order#{h.order_id}.id,
            created_at: '#{h.created_at.strftime('%d/%m/%Y')}')
        end
      HEREDOC
    end
  end
end
