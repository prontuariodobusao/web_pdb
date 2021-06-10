(1..5).each do |n|
  User.create(
    name: "Usuario #{n}",
    identity: "user_#{n}",
    email: "user_#{n}@mail.com",
    password: 'abc123',
    password_confirmation: 'abc123'
  )
end
