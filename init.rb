require 'rubygems'
require 'activerecord'

MY_ENVIRONMENT = ARGV[0] || 'development'
require 'environment'

if File.exists?(YAML::load(File.open('config.yml'))[MY_ENVIRONMENT]['database'])
  ActiveRecord::Base.connection.execute("DROP TABLE tweets")
  ActiveRecord::Base.connection.execute("DROP TABLE users")
end

ActiveRecord::Base.connection.execute("CREATE TABLE tweets (
  id INTEGER, 
  text TEXT, 
  from_user TEXT, 
  source TEXT, 
  event TEXT, 
  profile_image_url TEXT, 
  created_at TEXT)"
)
ActiveRecord::Base.connection.execute("CREATE TABLE users (
  id INTEGER,
  userid INTEGER,
  name TEXT,
  user TEXT,
  profile_image_url TEXT,
  posts INTEGER,
  event TEXT)"
)
