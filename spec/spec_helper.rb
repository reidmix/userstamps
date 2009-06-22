begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError => e
  puts e
  puts "You need to install rspec in your base app"
  exit
end

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")
