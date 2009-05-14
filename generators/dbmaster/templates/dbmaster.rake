namespace :db do
  namespace :master do
    desc "Load master data from/master/*.yml"
    task :load => :environment do |t, arg|
      puts "\n=== Loading YAML ..."
      require "load_masters.rb"
      MasterLoader.run
    end
  end
end
