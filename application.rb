require 'rubygems'
require 'activerecord'
require 'sinatra'
require 'environment'
require 'haml'
require 'json'

get '/' do
  "No content. Try access http://#{request.env['HTTP_HOST']}/whatever<br><br>:)"
end

get '/:event' do
  content_type "text/html", :charset => "utf-8"
  @key = params['event']
  @tweets = Tweet.all(:conditions => ["event = ?", @key], :order => 'id DESC', :limit => 30)
  @users  = User.all(:conditions => ["event = ?", @key], :order => 'posts DESC', :limit => 40)
  @max_id = @tweets.first.id
  haml :index
end

get '/:event/users' do
  content_type "application/javascript", :charset => "utf-8"
  @users = User.all(:conditions => ["event = ?", params['event']], :order => 'posts DESC', :limit => 40)
  @users.to_json
end

get '/:event/recents/:max_id' do
  content_type "application/javascript", :charset => "utf-8"
  tweets = Tweet.all(:conditions => ["id > ? and event = ?", params[:max_id], params[:event]], :order => "id ASC")
  tweets.each { |t| t.to_time! }
  tweets.to_json
end

