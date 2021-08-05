User.create!(name: "pham minh",
            email: "phamminh@gmail.com",
            password: "phamminh0210",
            password_confirmation: "phamminh0210",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)
User.create!(name: "minh pham",
            email: "minhpham@gmail.com",
            password: "phamminh0210",
            password_confirmation: "phamminh0210",
            activated: true,
            activated_at: Time.zone.now)

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
  email: email,
  password: password,
  password_confirmation: password,
  activated: true,
  activated_at: Time.zone.now)
end
