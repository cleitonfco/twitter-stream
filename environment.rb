require 'yaml'

environment = defined?(Sinatra) ? Sinatra::Base.environment.to_s : MY_ENVIRONMENT

ActiveRecord::Base.establish_connection(YAML::load(File.open('config.yml'))[environment])

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }

