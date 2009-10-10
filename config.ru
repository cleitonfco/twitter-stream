require 'application'

## To use with thin 
##  thin start -p PORT -R config.ru (-e ENVIRONMENT)

# Sinatra defines #set at the top level as a way to set application configuration
set :views, 'views'
set :run, false
set :environment, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
