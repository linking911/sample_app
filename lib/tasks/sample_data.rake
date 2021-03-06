namespace :db do
  desc "Fill database with sample data"
  
  task populate: :environment do
    admin = User.create!(
      name: "Example User",
      email: "admin@railstutorial.org",
      password: "foobar",
      password_confirmation: "foobar",
      admin: true
    )
    
    User.create!(
      name: "Example User", 
      email: "example@railstutorial.org",
      password: "foobar",
      password_confirmation: "foobar"
    )
    
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n + 1}@railstutorial.org"
      password= "password"
      User.create!(
        name: name, 
        email: email, 
        password: password, 
        password_confirmation: password
      )
    end
    
    # 为6个用户生成微博
    users = User.all(limit: 6)
    50.times do 
      # 生成实例文字
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
    
  end
end