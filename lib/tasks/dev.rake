namespace :dev do
  task fake_restaurant: :environment do # 載入環境，才能與Rails Model 互動
    Restaurant.destroy_all

    500.times do |i|
      # 若不是用 .create! 即便出現錯誤，還是會 create 所有筆數
      Restaurant.create!(name: FFaker::Name.first_name, 
        opening_hours: FFaker::Time.datetime, 
        tel: FFaker::PhoneNumber.short_phone_number, 
        address: FFaker::Address.street_address, 
        description: FFaker::Lorem.paragraph, 
        category: Category.all.sample,
        image: File.open(File.join(Rails.root, "/public/seed_img/#{rand(0..20)}.jpg"))
      )
    end
    puts "have created fake restaurant"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(
        email: "#{user_name}@example.com",
        password: "123456"
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_comment: :environment do
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
          # User.all.sample：從 所有的 user_id 隨機挑一個
        )
      end
    end
    puts "ave created fake comments"
    puts "now you have #{Comment.count} comments data"
  end

end