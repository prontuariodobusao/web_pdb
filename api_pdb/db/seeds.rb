puts 'Create Occupations...'
driver = Occupation.create(name: 'Motorista', type_occupation: :driver)
manager = Occupation.create(name: 'Gerente', type_occupation: :manager)
mecanic = Occupation.create(name: 'Mecãnico', type_occupation: :mecanic)
rh = Occupation.create(name: 'RH', type_occupation: :rh)
visitor = Occupation.create(name: 'Prefeitura', type_occupation: :visitor)
puts 'Occupations created'

puts 'Create Employees...'
employee1 = Employee.create(name: 'Edson', identity: '111', occupation: driver)
employee2 = Employee.create(name: 'Albert', identity: '112', occupation: driver)
employee3 = Employee.create(name: 'Braga', identity: '113', occupation: driver)

mecanic1 = Employee.create(name: 'Ivan', identity: '211', occupation: mecanic)
mecanic2 = Employee.create(name: 'Nonato', identity: '212', occupation: mecanic)
mecanic3 = Employee.create(name: 'Osvaldo', identity: '213', occupation: mecanic)

employee21 = Employee.create(name: 'Jorge', identity: '313', occupation: manager)
employee22 = Employee.create(name: 'Thiago', identity: '314', occupation: manager)
employee23 = Employee.create(name: 'Jr', identity: '315', occupation: manager)
employee24 = Employee.create(name: 'Dereck', identity: '316', occupation: manager)
employee25 = Employee.create(name: 'Jean', identity: '317', occupation: manager)
employee26 = Employee.create(name: 'Sabrina', identity: '318', occupation: manager)
employee27 = Employee.create(name: 'Felipe', identity: '319', occupation: manager)
employee28 = Employee.create(name: 'Diego', identity: '310', occupation: manager)

rh = Employee.create(name: 'Tatiana', identity: '411', occupation: rh)

pf = Employee.create(name: 'Prefeitura de teresina', identity: '412', occupation: visitor)

puts 'Employees created'


puts 'Create Users...'

user_rh = User.new(username: rh.identity, password: 'abc123', password_confirmation: 'abc123', employee: rh)
user_rh.save!
user_rh.add_role :rh

user_pf = User.new(username: pf.identity, password: 'abc123', password_confirmation: 'abc123', employee: pf)
user_pf.save!
user_pf.add_role :visitor

u1 = User.new(username: employee1.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee1)
u1.save!
u1.add_role :admin
u2 = User.new(username: employee2.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee2)
u2.save!
u2.add_role :admin
u3 = User.new(username: employee3.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee3)
u3.save!
u3.add_role :admin
u4 = User.new(username: employee21.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee21)
u4.save!
u4.add_role :admin
u5 = User.new(username: employee22.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee22)
u5.save!
u5.add_role :admin
u6 = User.new(username: employee23.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee23)
u6.save!
u6.add_role :admin
u7 = User.new(username: employee24.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee24)
u7.save!
u7.add_role :admin
u8 = User.new(username: employee25.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee25)
u8.save!
u8.add_role :admin
u9 = User.new(username: employee26.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee26)
u9.save!
u9.add_role :admin
u10 = User.new(username: employee27.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee27)
u10.save!
u1.add_role :admin
u11 = User.new(username: employee28.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee28)
u11.save!
u11.add_role :admin

puts 'Create Categories...'
enginer = Category.create(name: 'MOTOR')
energy = Category.create(name: 'ELÉTRICA')
bodywork = Category.create(name: 'CARROCERIA')
suspension = Category.create(name: 'SUSPENSÃO')

puts 'Create Problems...'
problem1 = Problem.create(description: 'Troca de óleo', priority: :high, category: enginer)
problem2 = Problem.create(description: 'Revisão de pneus', priority: :high, category: bodywork)
problem3 = Problem.create(description: 'Revisão Geral', priority: :high, category: bodywork)
problem4 = Problem.create(description: 'Perda de força', priority: :high, category: enginer)
problem5 = Problem.create(description: 'Aquecendo', priority: :high, category: enginer)
problem6 = Problem.create(description: 'Falhando', priority: :high, category: enginer)
problem7 = Problem.create(description: 'Cortando o óleo/bico injetor', priority: :high, category: enginer)
problem8 = Problem.create(description: 'Fumaçando', priority: :high, category: enginer)
problem9 = Problem.create(description: 'Sirene', priority: :normal, category: energy)
problem10 = Problem.create(description: 'Faróis', priority: :normal, category: energy)
problem11 = Problem.create(description: 'Pisca', priority: :normal, category: energy)
problem12 = Problem.create(description: 'Controcity', priority: :normal, category: energy)
problem13 = Problem.create(description: 'Luz de salão', priority: :high, category: energy)
problem14 = Problem.create(description: 'Buzina', priority: :normal, category: energy)
problem15 = Problem.create(description: 'Janela quebrada', priority: :easy, category: bodywork)
problem16 = Problem.create(description: 'Banco com folga ou sujo', priority: :high, category: bodywork)
problem17 = Problem.create(description: 'Sem fumê', priority: :normal, category: bodywork)
problem18 = Problem.create(description: 'Porta não abre ou fecha direito', priority: :high, category: bodywork)
problem19 = Problem.create(description: 'Elevador Cadeirante', priority: :high, category: bodywork)
problem20 = Problem.create(description: 'Mola Mestre', priority: :high, category: suspension)
problem21 = Problem.create(description: 'Amortecedor', priority: :high, category: suspension)
problem22 = Problem.create(description: 'Feixo de molas', priority: :normal, category: suspension)
problem23 = Problem.create(description: 'Barra estabilizadora', priority: :high, category: suspension)

solution1 = Solution.create(description: 'Trocar o óleo', problem: problem1)
solution2 = Solution.create(description: 'Revisar pneus', problem: problem2)
solution3 = Solution.create(description: 'Revisar veículo', problem: problem3)
solution4 = Solution.create(description: 'Verificar injeção', problem: problem4)
solution5 = Solution.create(description: 'Completar água', problem: problem5)
solution6 = Solution.create(description: 'Verificar nível do óleo', problem: problem6)
Solution.create(description: 'Verificar sistema de injeção', problem: problem7)
Solution.create(description: 'Refazer o motor, ou verificar excesso de óleo nos pistões', problem: problem8)
Solution.create(description: 'Fusível queimado', problem: problem9) 
Solution.create(description: 'Troca de lentes ou lâmpadas', problem: problem10)
Solution.create(description: 'Substituir relé de pisca', problem: problem11)
Solution.create(description: 'Checar bateria', problem: problem12)
Solution.create(description: 'Verificar parte eletrica (instalação, fuzível e etc)', problem: problem13)
Solution.create(description: 'Trocar ou ver fusível', problem: problem14)
Solution.create(description: 'Substituir janela', problem: problem15)
Solution.create(description: 'Apertar banco ou trocar', problem: problem16)
Solution.create(description: 'Colocar cortina', problem: problem17)
Solution.create(description: 'Revisar às válvulas das portas', problem: problem18)
Solution.create(description: 'Revisar elevador', problem: problem19)
Solution.create(description: 'Trocar mola Mestre', problem: problem20)
Solution.create(description: 'Substituir amortecedor', problem: problem21)
Solution.create(description: 'Bater molas ou colocar abraçadeiras', problem: problem22)
Solution.create(description: 'Verificar buchas e coxins', problem: problem23)

puts 'Create Car lines...'
line1 = CarLine.create(name: 'A 708 Porto Alegre', line_type: :feeder)
line2 = CarLine.create(name: 'A 709 Cidade Sul', line_type: :feeder)
line3 = CarLine.create(name: 'A 713 Mário Covas', line_type: :feeder)
line4 = CarLine.create(name: 'A 714 Eduardo Costa', line_type: :feeder)
CarLine.create(name: 'Reserva', line_type: :reserve)

puts 'Create Vehicles...'
vehicle1 = Vehicle.create(km: 27_000, car_number: '04383', car_line: line1, oil_date: Date.current, tire_date: Date.current, revision_date: Date.current)
vehicle2 = Vehicle.create(km: 33_000, car_number: '04384', car_line: line2, oil_date: Date.current, tire_date: Date.current, revision_date: Date.current)
vehicle3 = Vehicle.create(km: 47_000, car_number: '04385', car_line: line3, oil_date: Date.current, tire_date: Date.current, revision_date: Date.current)
vehicle4 = Vehicle.create(km: 65_000, car_number: '04386', car_line: line4, oil_date: Date.current, tire_date: Date.current, revision_date: Date.current)
vehicle5 = Vehicle.create(km: 70_000, car_number: '04387', car_line: line4, oil_date: Date.current, tire_date: Date.current, revision_date: Date.current)

status = Status.find 4
maintenance = Status.find 2

puts 'Create orders of revisons to vehicle one'
order1 = Order.create(km: 15_000, reference: 'OS_00001/2021', state: :closed, status: status, owner: u1, problem: problem1, vehicle: vehicle1, solution: solution1, manager: employee27, car_mecanic: mecanic1)
order1.histories.create!(km: order1.km, description: 'Manutenção', status: maintenance, owner: order1.owner)
order1.histories.create!(km: order1.km, description: 'Finalização', status: status, owner: order1.owner)

order2 = Order.create(km: 15_000, reference: 'OS_00002/2021', state: :closed, status: status, owner: u1, problem: problem2, vehicle: vehicle1, solution: solution2, manager: employee27, car_mecanic: mecanic2)
order2.histories.create!(km: order2.km, description: 'Manutenção', status: maintenance, owner: order2.owner)
order2.histories.create!(km: order2.km, description: 'Finalização', status: status, owner: order2.owner)

order3 = Order.create(km: 15_000, reference: 'OS_00003/2021', state: :closed, status: status, owner: u1, problem: problem3, vehicle: vehicle1, solution: solution3, manager: employee27, car_mecanic: mecanic3)
order3.histories.create!(km: order3.km, description: 'Manutenção', status: maintenance, owner: order3.owner)
order3.histories.create!(km: order3.km, description: 'Finalização', status: status, owner: order3.owner)

puts 'Create orders of revisons to vehicle two'
order4 = Order.create(km: 30_000, reference: 'OS_00004/2021', state: :closed, status: status, owner: u2, problem: problem1, vehicle: vehicle2, solution: solution1, manager: employee27, car_mecanic: mecanic1)
order4.histories.create!(km: order4.km, description: 'Manutenção', status: maintenance, owner: order4.owner)
order4.histories.create!(km: order4.km, description: 'Finalização', status: status, owner: order4.owner)

order5 = Order.create(km: 30_000, reference: 'OS_00005/2021', state: :closed, status: status, owner: u2, problem: problem2, vehicle: vehicle2, solution: solution2, manager: employee27, car_mecanic: mecanic1)
order5.histories.create!(km: order5.km, description: 'Manutenção', status: maintenance, owner: order5.owner)
order5.histories.create!(km: order5.km, description: 'Finalização', status: status, owner: order5.owner)

order6 = Order.create(km: 30_000, reference: 'OS_00006/2021', state: :closed, status: status, owner: u2, problem: problem3, vehicle: vehicle2, solution: solution3, manager: employee27, car_mecanic: mecanic1)
order6.histories.create!(km: order6.km, description: 'Manutenção', status: maintenance, owner: order6.owner)
order6.histories.create!(km: order6.km, description: 'Finalização', status: status, owner: order6.owner)

puts 'Create orders of revisons to vehicle three'
order7 = Order.create(km: 45_000, reference: 'OS_00007/2021', state: :closed, status: status, owner: u3, problem: problem1, vehicle: vehicle3, solution: solution1, manager: employee27, car_mecanic: mecanic2)
order7.histories.create!(km: order7.km, description: 'Manutenção', status: maintenance, owner: order7.owner)
order7.histories.create!(km: order7.km, description: 'Finalização', status: status, owner: order7.owner)

order8 = Order.create(km: 45_000, reference: 'OS_00008/2021', state: :closed, status: status, owner: u3, problem: problem2, vehicle: vehicle3, solution: solution2, manager: employee27, car_mecanic: mecanic2)
order8.histories.create!(km: order8.km, description: 'Manutenção', status: maintenance, owner: order8.owner)
order8.histories.create!(km: order8.km, description: 'Finalização', status: status, owner: order8.owner)

order9 = Order.create(km: 45_000, reference: 'OS_00009/2021', state: :closed, status: status, owner: u3, problem: problem3, vehicle: vehicle3, solution: solution3, manager: employee27, car_mecanic: mecanic3)
order9.histories.create!(km: order9.km, description: 'Manutenção', status: maintenance, owner: order9.owner)
order9.histories.create!(km: order9.km, description: 'Finalização', status: status, owner: order9.owner)

puts 'Create orders of revisons to vehicle four'
order10 = Order.create(km: 60_000, reference: 'OS_00010/2021', state: :closed, status: status, owner: u1, problem: problem1, vehicle: vehicle4, solution: solution1, manager: employee27, car_mecanic: mecanic3)
order10.histories.create!(km: order10.km, description: 'Manutenção', status: maintenance, owner: order10.owner)
order10.histories.create!(km: order10.km, description: 'Finalização', status: status, owner: order10.owner)

order11 = Order.create(km: 60_000, reference: 'OS_00011/2021', state: :closed, status: status, owner: u1, problem: problem2, vehicle: vehicle4, solution: solution2, manager: employee27, car_mecanic: mecanic3)
order11.histories.create!(km: order11.km, description: 'Manutenção', status: maintenance, owner: order11.owner)
order11.histories.create!(km: order11.km, description: 'Finalização', status: status, owner: order11.owner)

order12 = Order.create(km: 60_000, reference: 'OS_00012/2021', state: :closed, status: status, owner: u1, problem: problem3, vehicle: vehicle4, solution: solution3, manager: employee27, car_mecanic: mecanic3)
order12.histories.create!(km: order12.km, description: 'Manutenção', status: maintenance, owner: order12.owner)
order12.histories.create!(km: order12.km, description: 'Finalização', status: status, owner: order12.owner)

puts 'Create orders of revisons to vehicle five'
order13 = Order.create(km: 75_000, reference: 'OS_00013/2021', state: :closed, status: status, owner: u1, problem: problem4, vehicle: vehicle5, solution: solution4, manager: employee27, car_mecanic: mecanic1, created_at: 60.days.ago)
order13.histories.create!(km: order13.km, description: 'Manutenção', status: maintenance, owner: order13.owner)
order13.histories.create!(km: order13.km, description: 'Finalização', status: status, owner: order13.owner)

order14 = Order.create(km: 85_000, reference: 'OS_00014/2021', state: :closed, status: status, owner: u1, problem: problem5, vehicle: vehicle5, solution: solution5, manager: employee27, car_mecanic: mecanic2, created_at: 30.days.ago)
order14.histories.create!(km: order14.km, description: 'Manutenção', status: maintenance, owner: order14.owner)
order14.histories.create!(km: order14.km, description: 'Finalização', status: status, owner: order14.owner)

order15 = Order.create(km: 90_000, reference: 'OS_00015/2021', state: :closed, status: status, owner: u1, problem: problem6, vehicle: vehicle5, solution: solution6, manager: employee27, car_mecanic: mecanic3, created_at: DateTime.current)
order15.histories.create!(km: order15.km, description: 'Manutenção', status: maintenance, owner: order15.owner)
order15.histories.create!(km: order15.km, description: 'Finalização', status: status, owner: order15.owner)
