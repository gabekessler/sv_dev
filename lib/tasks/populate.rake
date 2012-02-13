namespace :db do
  desc 'add projects to db for testing'
  puts 'creating...'
  task :populate => :environment do
    100.times do
      Page.create
    end
  end
end