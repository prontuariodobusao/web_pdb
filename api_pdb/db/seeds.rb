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
employee3 = Employee.create(name: 'Galdino', identity: '113', occupation: driver)
employee4 = Employee.create(name: 'Guilherme', identity: '114', occupation: driver)
employee5 = Employee.create(name: 'Campelo', identity: '115', occupation: driver)
employee6 = Employee.create(name: 'Isaias', identity: '116', occupation: driver)
employee7 = Employee.create(name: 'Francisco', identity: '117', occupation: driver)
employee8 = Employee.create(name: 'Antônio Sousa', identity: '118', occupation: driver)
employee9 = Employee.create(name: 'Pacheco', identity: '119', occupation: driver)
employee10 = Employee.create(name: 'Braga', identity: '110', occupation: driver)
Employee.create(name: 'Ivan', identity: '211', occupation: mecanic)
Employee.create(name: 'Nonato', identity: '212', occupation: mecanic)
Employee.create(name: 'Osvaldo', identity: '213', occupation: mecanic)
Employee.create(name: 'Josenildo', identity: '214', occupation: mecanic)
Employee.create(name: 'Walisson', identity: '215', occupation: mecanic)
Employee.create(name: 'Chico Velho', identity: '216', occupation: mecanic)
Employee.create(name: 'Marcos', identity: '217', occupation: mecanic)
Employee.create(name: 'Bena', identity: '218', occupation: mecanic)

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
rh = Employee.create(name: 'Tatiana', identity: '411', occupation: rh)
pf = Employee.create(name: 'Prefeitura de teresina', identity: '412', occupation: visitor)

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
  employee19,
  employee20
)

puts 'Create Users...'

user_rh = User.new(username: rh.identity, password: 'abc123', password_confirmation: 'abc123', employee: rh)
user_rh.save!
user_rh.add_role :rh

user_pf = User.new(username: pf.identity, password: 'abc123', password_confirmation: 'abc123', employee: pf)
user_pf.save!
user_pf.add_role :visitor

employees.each do |employee|
  user = User.new(username: employee.identity, password: 'abc123', password_confirmation: 'abc123', employee: employee)
  user.save!
  user.add_role :normal
end

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
problem1 = Problem.create(description: 'Óleo baixo', priority: :high, category: enginer)
problem2 = Problem.create(description: 'Perda de força', priority: :high, category: enginer)
problem3 = Problem.create(description: 'Aquecendo', priority: :high, category: enginer)
problem4 = Problem.create(description: 'Falhando', priority: :high, category: enginer)
problem5 = Problem.create(description: 'Cortando o óleo/bico injetor', priority: :high, category: enginer)
problem6 = Problem.create(description: 'Fumaçando', priority: :high, category: enginer)
problem7 = Problem.create(description: 'Cirene', priority: :normal, category: energy)
problem8 = Problem.create(description: 'Faróis', priority: :normal, category: energy)
problem9 = Problem.create(description: 'Pisca', priority: :normal, category: energy)
problem10 = Problem.create(description: 'Controcity', priority: :normal, category: energy)
problem11 = Problem.create(description: 'Luz de salão', priority: :high, category: energy)
problem12 = Problem.create(description: 'Buzina', priority: :normal, category: energy)
problem13 = Problem.create(description: 'Janela quebrada', priority: :easy, category: bodywork)
problem14 = Problem.create(description: 'Banco com folga ou sujo', priority: :high, category: bodywork)
problem15 = Problem.create(description: 'Sem fumê', priority: :normal, category: bodywork)
problem16 = Problem.create(description: 'Porta não abre ou fecha direito', priority: :high, category: bodywork)
problem17 = Problem.create(description: 'Elevador Cadeirante', priority: :high, category: bodywork)
problem18 = Problem.create(description: 'Mola Mestre', priority: :high, category: suspension)
problem19 = Problem.create(description: 'Amortecedor', priority: :high, category: suspension)
problem20 = Problem.create(description: 'Feixo de molas', priority: :normal, category: suspension)
problem21 = Problem.create(description: 'Barra estabilizadora', priority: :high, category: suspension)

Solution.create(description: 'Completar o óleo', problem: problem1)
Solution.create(description: 'Verificar injeção', problem: problem2)
Solution.create(description: 'Completar água', problem: problem3)
Solution.create(description: 'Verificar nível do óleo', problem: problem4)
Solution.create(description: 'Verificar sistema de injeção', problem: problem5)
Solution.create(description: 'Refazer o motor, ou verificar excesso de óleo nos pistões', problem: problem6)
Solution.create(description: 'Fusível queimado', problem: problem7) 
Solution.create(description: 'Troca de lentes ou lâmpadas', problem: problem8)
Solution.create(description: 'Substituir relé de pisca', problem: problem9)
Solution.create(description: 'Checar bateria', problem: problem10)
Solution.create(description: 'Verificar parte eletrica (instalação, fuzível e etc)', problem: problem11)
Solution.create(description: 'Trocar ou ver fusível', problem: problem12)
Solution.create(description: 'Substituir janela', problem: problem13)
Solution.create(description: 'Apertar banco ou trocar', problem: problem14)
Solution.create(description: 'Colocar cortina', problem: problem15)
Solution.create(description: 'Revisar às válvulas das portas', problem: problem16)
Solution.create(description: 'Revisar elevador', problem: problem17)
Solution.create(description: 'Trocar mola Mestre', problem: problem18)
Solution.create(description: 'Substituir amortecedor', problem: problem19)
Solution.create(description: 'Bater molas ou colocar abraçadeiras', problem: problem20)
Solution.create(description: 'Verificar buchas e coxins', problem: problem21)

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
Vehicle.create(car_number: '04383', car_line: line1)
Vehicle.create(car_number: '04384', car_line: line2)
Vehicle.create(car_number: '04385', car_line: line3)
Vehicle.create(car_number: '04386', car_line: line4)
Vehicle.create(car_number: '04387', car_line: line5)
Vehicle.create(car_number: '04388', car_line: line6)

Vehicle.create(car_number: '04389', car_line: line7)
Vehicle.create(car_number: '04390', car_line: line8)
Vehicle.create(car_number: '04391', car_line: line9)
Vehicle.create(car_number: '04392', car_line: line10)
Vehicle.create(car_number: '04393', car_line: line11)
Vehicle.create(car_number: '04394', car_line: line12)

Vehicle.create(car_number: '04360', car_line: reserve)
Vehicle.create(car_number: '04361', car_line: reserve)
Vehicle.create(car_number: '04362', car_line: reserve)

