require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'qiglV81eUy3Pp1A0pflv8Dm4j'
  config.consumer_secret = 'cge5fPDrtjBPB3rJll3gLjKaVeDvOYLqhCOOpLe9CAEvRIWxaN'
  config.access_token = '117905896-7snKof0PHWlCxXJ8X0Utvupupbbh5emGrXJGt3LD'
  config.access_token_secret = 'FXLbVw7QkXUpmXAai3FCYeIKaJgXbzZrAc2M3HFrXtz99'
end

search_term = URI::encode('#todayilearned')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end