class CreateStatuses < ActiveRecord::Migration[6.1]
  def up
    create_table :statuses do |t|
      t.string :name, null: false
      t.integer :color, null: false, default: 0
    end

    Status.create(name: 'Pendente', color: :orange)
    Status.create(name: 'Manutenção', color: :blue)
    Status.create(name: 'Cancelada', color: :red)
    Status.create(name: 'Finalizada', color: :green)
  end

  def down
    drop_table :statuses
  end
end
