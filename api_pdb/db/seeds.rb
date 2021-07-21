puts 'Create Occupations...'
driver = Occupation.create(name: 'Motorista')
manager = Occupation.create(name: 'Gerente')
mecanic = Occupation.create(name: 'Mecãnico')
rh = Occupation.create(name: 'RH')
puts 'Occupations created'

puts 'Create Employees...'
employee1 = Employee.create(name: 'Edson', identity: '111', occupation: driver)
employee2 = Employee.create(name: 'Albert', identity: '112', occupation: driver)
employee3 = Employee.create(name: 'Galdino', identity: '113', occupation: driver)
employee4 = Employee.create(name: 'Guilherme', identity: '114', occupation: driver)
employee5 = Employee.create(name: 'Campelo', identity: '115', occupation: driver)
employee6 = Employee.create(name: 'Isaias', identity: '116', occupation: driver)
employee7 = Employee.create(name: 'Francisco', identity: '117', occupation: driver)
employee8 = Employee.create(name: 'Antônio Sousa', identity: '118', occupation: driver)
employee9 = Employee.create(name: 'Pacheco', identity: '119', occupation: driver)
employee10 = Employee.create(name: 'Braga', identity: '110', occupation: driver)
employee11 = Employee.create(name: 'Ivan', identity: '211', occupation: mecanic)
employee12 = Employee.create(name: 'Nonato', identity: '212', occupation: mecanic)
employee13 = Employee.create(name: 'Osvaldo', identity: '213', occupation: mecanic)
employee14 = Employee.create(name: 'Josenildo', identity: '214', occupation: mecanic)
employee15 = Employee.create(name: 'Walisson', identity: '215', occupation: mecanic)
employee16 = Employee.create(name: 'Chico Velho', identity: '216', occupation: mecanic)
employee17 = Employee.create(name: 'Marcos', identity: '217', occupation: mecanic)
employee18 = Employee.create(name: 'Bena', identity: '218', occupation: mecanic)

employee19 = Employee.create(name: 'Marcos', identity: '311', occupation: manager)
employee20 = Employee.create(name: 'Cesar', identity: '312', occupation: manager)
employee21 = Employee.create(name: 'Jorge', identity: '313', occupation: manager)
employee22 = Employee.create(name: 'Thiago', identity: '314', occupation: manager)
employee23 = Employee.create(name: 'Jr', identity: '315', occupation: manager)
employee24 = Employee.create(name: 'Dereck', identity: '316', occupation: manager)
employee25 = Employee.create(name: 'Jean', identity: '317', occupation: manager)
employee26 = Employee.create(name: 'Sabrina', identity: '318', occupation: manager)
employee27 = Employee.create(name: 'Felipe', identity: '319', occupation: manager)
employee28 = Employee.create(name: 'Diego', identity: '310', occupation: manager)

employee29 = Employee.create(name: 'Tatiana', identity: '411', occupation: rh)
puts 'Employees created'

employees = []
employees.push(
  employee4,
  employee5,
  employee6,
  employee7,
  employee8,
  employee9,
  employee10,
  employee11,
  employee12,
  employee13,
  employee14,
  employee15,
  employee16,
  employee17,
  employee18,
  employee19,
  employee20,
  employee29
)

puts 'Create Users...'
employees.each do |employee|
  User.create(username: employee.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee)
end

user1 = User.create(username: employee1.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee1)
user2 = User.create(username: employee2.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee2)
user3 = User.create(username: employee3.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee3)
user4 = User.create(username: employee21.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee21)
user5 = User.create(username: employee22.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee22)
user6 = User.create(username: employee23.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee23)
user7 = User.create(username: employee24.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee24)
user8 = User.create(username: employee25.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee25)
user9 = User.create(username: employee26.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee26)
user10 = User.create(username: employee27.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee27)
user11 = User.create(username: employee28.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee28)

puts 'Create Categories...'
enginer = Category.create(name: 'MOTOR')
energy = Category.create(name: 'ELÉTRICA')
bodywork = Category.create(name: 'CARROCERIA')
suspension = Category.create(name: 'SUSPENSÃO')

puts 'Create Problems...'
problem1 = Problem.create(description: 'Óleo baixo', solution: 'Completar o óleo	Alta', priority: :high, category: enginer)
problem2 = Problem.create(description: 'Perda de força', solution: 'Verificar injeção', priority: :high, category: enginer)
problem3 = Problem.create(description: 'Aquecendo', solution: 'Completar água', priority: :high, category: enginer)
problem4 = Problem.create(description: 'Falhando', solution: 'Verificar nível do óleo', priority: :high, category: enginer)
problem5 = Problem.create(description: 'Cortando o óleo/bico injetor', solution: 'Verificar sistema de injeção', priority: :high, category: enginer)
problem6 = Problem.create(description: 'Fumaçando', solution: 'Refazer o motor, ou verificar excesso de óleo nos pistões', priority: :high, category: enginer)
Problem.create(description: 'Cirene', solution: 'Fusível queimado', priority: :normal, category: energy)
Problem.create(description: 'Faróis', solution: 'Troca de lentes ou lâmpadas', priority: :normal, category: energy)
Problem.create(description: 'Pisca', solution: 'Substituir relé de pisca', priority: :normal, category: energy)
Problem.create(description: 'Controcity', solution: 'Checar bateria', priority: :normal, category: energy)
Problem.create(description: 'Luz de salão', solution: 'Verificar parte eletrica (instalação, fuzível e etc)', priority: :high, category: energy)
Problem.create(description: 'Buzina', solution: 'Trocar ou ver fusível', priority: :normal, category: energy)
Problem.create(description: 'Janela quebrada', solution: 'Substituir janela', priority: :easy, category: bodywork)
Problem.create(description: 'Banco com folga ou sujo', solution: 'Apertar banco ou trocar', priority: :high, category: bodywork)
Problem.create(description: 'Sem fumê', solution: 'Colocar cortina', priority: :normal, category: bodywork)
Problem.create(description: 'Porta não abre ou fecha direito', solution: 'Revisar às válvulas das portas', priority: :high, category: bodywork)
Problem.create(description: 'Elevador Cadeirante', solution: 'Revisar elevador', priority: :high, category: bodywork)
Problem.create(description: 'Mola Mestre', solution: 'Trocar mola Mestre', priority: :high, category: suspension)
Problem.create(description: 'Amortecedor', solution: 'Substituir amortecedor', priority: :high, category: suspension)
Problem.create(description: 'Feixo de molas', solution: 'Bater molas ou colocar abraçadeiras', priority: :normal, category: suspension)
Problem.create(description: 'Barra estabilizadora', solution: 'Verificar buchas e coxins', priority: :high, category: suspension)

puts 'Create Statuses...'
status1 = Status.create(name: 'Entrada', color: :yellow)
Status.create(name: 'Manutenção', color: :red)
status3 = Status.create(name: 'Finalizada', color: :green)

puts 'Create Car lines...'
line1 = CarLine.create(name: 'A 708 Porto Alegre', line_type: :feeder)
line2 = CarLine.create(name: 'A 709 Cidade Sul', line_type: :feeder)
line3 = CarLine.create(name: 'A 713 Mário Covas', line_type: :feeder)
line4 = CarLine.create(name: 'A 714 Eduardo Costa', line_type: :feeder)
line5 = CarLine.create(name: 'A 715 Teresina Sul', line_type: :feeder)
line6 = CarLine.create(name: 'A 708 Vila irmã Dulce', line_type: :feeder)

line7 = CarLine.create(name: 'T 801 Parque Piauí Barão', line_type: :stem)
line8 = CarLine.create(name: 'T 802 Parque Piauí Shopping', line_type: :stem)
line9 = CarLine.create(name: 'T 803 Parque Piauí Pedro Freitas', line_type: :stem)
line10 = CarLine.create(name: 'T 804 Parque Piauí Miguel Rosa Shopping', line_type: :stem)
line11 = CarLine.create(name: 'T 805 Bela Vista Barão', line_type: :stem)
line12 = CarLine.create(name: 'T 806 Bela Vista Shopping', line_type: :stem)

reserve = CarLine.create(name: 'Reserva', line_type: :reserve)

puts 'Create Vehicles...'
vehicle1 = Vehicle.create(car_number: '04383', car_line: line1)
vehicle2 = Vehicle.create(car_number: '04384', car_line: line2)
vehicle3 = Vehicle.create(car_number: '04385', car_line: line3)
vehicle4 = Vehicle.create(car_number: '04386', car_line: line4)
vehicle5 = Vehicle.create(car_number: '04387', car_line: line5)
vehicle6 = Vehicle.create(car_number: '04388', car_line: line6)

Vehicle.create(car_number: '04389', car_line: line7)
Vehicle.create(car_number: '04390', car_line: line8)
Vehicle.create(car_number: '04391', car_line: line9)
Vehicle.create(car_number: '04392', car_line: line10)
Vehicle.create(car_number: '04393', car_line: line11)
Vehicle.create(car_number: '04394', car_line: line12)

Vehicle.create(car_number: '04360', car_line: reserve)
Vehicle.create(car_number: '04361', car_line: reserve)
Vehicle.create(car_number: '04362', car_line: reserve)

puts 'Create Orders...'
Order.create(km: '1890', reference: 'OS12394/2021', problem: problem6, vehicle: vehicle6, status: status1, owner: user4)

Order.create(km: '2190', reference: 'OS12334/2021', state: :closed, problem: problem1, vehicle: vehicle1, status: status3, owner: user1)
Order.create(km: '2340', reference: 'OS12374/2021', state: :closed, problem: problem2, vehicle: vehicle2, status: status3, owner: user2)
Order.create(km: '2190', reference: 'OS12384/2021', state: :closed, problem: problem3, vehicle: vehicle3, status: status3, owner: user3)
Order.create(km: '2800', reference: 'OS12324/2021', state: :closed, problem: problem4, vehicle: vehicle4, status: status3, owner: user4)
Order.create(km: '2000', reference: 'OS12354/2021', state: :closed, problem: problem5, vehicle: vehicle5, status: status3, owner: user5)
Order.create(km: '2000', reference: 'OS12554/2021', state: :closed, problem: problem5, vehicle: vehicle5, status: status3, owner: user6)
Order.create(km: '2000', reference: 'OS12654/2021', state: :closed, problem: problem5, vehicle: vehicle5, status: status3, owner: user7)
Order.create(km: '2000', reference: 'OS12754/2021', state: :closed, problem: problem5, vehicle: vehicle5, status: status3, owner: user8)
Order.create(km: '2000', reference: 'OS12854/2021', state: :closed, problem: problem5, vehicle: vehicle5, status: status3, owner: user9)
Order.create(km: '2000', reference: 'OS12954/2021', state: :closed, problem: problem5, vehicle: vehicle5, status: status3, owner: user10)
Order.create(km: '2000', reference: 'OS12154/2021', state: :closed, problem: problem5, vehicle: vehicle5, status: status3, owner: user11)
