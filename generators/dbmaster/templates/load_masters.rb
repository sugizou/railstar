#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

unless defined? __DIR__
  def __DIR__
    filename = caller[0][/^(.*):/, 1]
    File.expand_path(File.dirname(filename))
  end
end
#puts fixture_dir
def fixture_dir
  File.expand_path("../db/master", __DIR__)
end

class MasterLoader
  class << self
    def run
      Dir::glob(fixture_dir + "/*.yml").each do |file|
        klass_name = File::basename(file, '.yml')
        run_class(klass_name)
      end
    end

    def run_class(klass_name)
      file = File.join(fixture_dir, klass_name + '.yml')
      klass_name = klass_name.classify

      puts "\t loading from #{File::basename(file)} via #{klass_name}"
      klass = eval(klass_name)
      rawdata = File.read(file)
      records = YAML::load(rawdata)
      klass.delete_all
      records.each do |rec|
        copied = klass.new(rec[1])
        copied.id = rec[1]["id"]
        copied.save
      end
    end
  end

end
