#!/usr/bin/env ruby

require 'rubygems'
require 'activerecord'
require 'net/http'
require 'json'

MY_ENVIRONMENT = ARGV[0] || 'development'
require 'environment'

term = 'railssummit'
url = 'http://search.twitter.com/search.json?q=' + URI.escape(term)
call = Net::HTTP.get_response(URI.parse(url))

if call.body && !(call.body =~ /You have been rate limited. Enhance your calm/)
  res = JSON.parse(call.body) 

  last = Tweet.find(:first, :order => "id DESC")

  new_tweets = res['results'].collect {|t| t if t['id'] > last.send(:id)}.compact

  if new_tweets.size > 0
    new_tweets.each do |t|
      unless Tweet.find_by_id(t['id'].to_i)
        tw = Tweet.new
        tw.id = t['id'].to_i
        text = t['text'].gsub(/(##{term})/i, "<span class=\"keyword\">\\1</span>")
        text.gsub!(/((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/[^ ]*)?)/i, "<a href=\"\\1\">\\1</a>")
        tw.text = text.gsub(/@([a-zA-Z0-9]+)\b/i, "<a href=\"http://twitter.com/\\1\" class=\"twitter_user\">@\\1</a>")
        tw.from_user = t['from_user']
        tw.source = t['source'].gsub(/&lt;/, '<').gsub(/&gt;/, '>').gsub(/&quot;/, '"')
        tw.profile_image_url = t['profile_image_url']
        tw.created_at = t['created_at']
        tw.event = term
        tw.save

        user = User.find_by_id_and_event(t['from_user_id'].to_i, term)
        if user
          user.posts += 1
          user.profile_image_url = t['profile_image_url']
          user.save
        else
          posts = 1
          user = User.new
          user.id = t['from_user_id'].to_i
          user.userid = t['from_user_id'].to_i
          user.name = ''
          user.user = t['from_user']
          user.profile_image_url = t['profile_image_url']
          user.posts = posts
          user.event = term
          user.save
        end
      end
    end
  end
end
