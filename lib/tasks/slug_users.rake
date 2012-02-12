namespace :users do
  desc 'slugs users already in db'
  task :slug_users => :environment do
    @users = User.all
    @users.each do |user|
      user.save
      puts "#{user.slug}"
    end
  end
  
  desc 'delete all Users, Authorizations, Friendships, Profiles in DB'
  task :clear => :environment do
    User.delete_all
    puts User.count
    Authentication.delete_all
    puts Authentication.count
    Friendship.delete_all
    puts Friendship.count
    Profile.delete_all
    Profile.count
  end
end