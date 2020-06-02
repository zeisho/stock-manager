User.create!(name: "Example User",
             email: "mazdarx808026672964@gmail.com",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
# 99.times do |n|
#   name = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password,
#               activated: true,
#               activated_at: Time.zone.now)
# end
               
# users = User.order(:created_at).take(6)
# 50.times do
#   name = Faker::Lorem.sentence(2)
#   users.each { |user| user.stocks.create!(name: name) }
# end
