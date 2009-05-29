class TwitterGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    Dir.mkdir("app/models") unless File.directory?("app/models")
    super
  end

  def manifest
    record do |m|
      m.directory 'app/models'
      m.file      'twitter.rb', 'app/models/twitter.rb'
    end
  end
end
