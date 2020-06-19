# Create a main sample user.
User.create!(name: "Hao Nguyen",
             email: "haoitutc@gmail.com",
             password: "haoitutc123",
             password_confirmation: "haoitutc123",
             admin: true)
# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "haoitutc-#{n+1}@gmail.com"
  password = "haoitutc123"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)

end
