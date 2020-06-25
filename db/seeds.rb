# Create a main sample user.
User.create!(name: "Hao Nguyen",
             email: "haoitutc@gmail.com",
             password: "haoitutc123",
             password_confirmation: "haoitutc123",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "haoitutc-#{n+1}@gmail.com"
  password = "haoitutc123"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)

end

users = User.order(:created_at).take(6)
30.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
