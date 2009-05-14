class DbmasterGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    Dir.mkdir("lib/tasks") unless File.directory?("lib/tasks")
    super
  end

  def manifest
    record do |m|
      m.directory 'lib/tasks'
      m.file      'dbmaster.rake', 'lib/tasks/dbmaster.rake'

      m.directory 'lib'
      m.file      'load_masters.rb', 'lib/load_masters.rb'
    end
  end
end
