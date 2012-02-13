namespace :db do
  desc 'add projects to db for testing'
  puts 'creating...'
  task :populate => :environment do
    100.times do
      title = Faker::Company.name
      number = Faker::PhoneNumber.phone_number
      Product.create(
        :title => title,
        :number => number
      )
    end
  end
end