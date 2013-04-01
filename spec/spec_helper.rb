require 'rubygems'
require 'bundler/setup'
require 'ekto'
require 'ostruct'
require 'open3'


PROJECT_PATH = Pathname.new(File.expand_path(File.dirname(__FILE__) + "../../"))
Dir[PROJECT_PATH.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.extend UniqueInstance
  config.include UniqueInstance::EachMethods
end
