namespace :dev do
  task fake: :environment do # 載入環境，才能與Rails Model 互動
    Restaurant.destroy_all

    500.times do |i|
      # 若不是用 .create! 即便出現錯誤，還是會 create 所有筆數
      Restaurant.create!(name: FFaker::Name.first_name, 
        opening_hours: FFaker::Time.datetime, 
        tel: FFaker::PhoneNumber.short_phone_number, 
        address: FFaker::Address.street_address, 
        description: FFaker::Lorem.paragraph, 
        category: Category.all.sample,
        image: File.open(File.join(Rails.root, "/public/seed_img/#{rand(0...20)}.jpg"))
      )
    end
    puts "have created fake restaurant"
    puts "now you have #{Restaurant.count} restaurants data"
  end
end