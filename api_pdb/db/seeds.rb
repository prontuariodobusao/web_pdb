(1..6).each do |n|
  user = User.create(
    name: "Usuario #{n}",
    identity: "user#{n}",
    password: 'abc123',
    password_confirmation: 'abc123'
  )
  puts "Usuário #{user.name} criado!"
end
