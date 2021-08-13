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

users = User.order(:created_at).take(6)
5.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user = users.first
following = users[2..10]
followers = users[3..11]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}
