namespace :users do
  desc 'slugs users already in db'
  task :slug_users => :environment do
    @users = User.all
    @users.each do |user|
      user.save
      puts "#{user.slug}"
    end
  end
end