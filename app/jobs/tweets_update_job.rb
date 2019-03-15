class TweetsUpdateJob < ApplicationJob
  queue_as :urgent

  def perform(search_term)
    begin
      twitter = TwitterClient.new
      tweets = twitter.client.search("##{search_term}", result_type: "recent").take(10)
      tweets.each do |tweet|
        Tweet.create(full_text: tweet.full_text, screen_name: tweet.user.screen_name, created_at: tweet.created_at, search_term: search_term)
      end
      self.class.set(wait: 5.minutes).perform_later(search_term)
    rescue HTTP::ConnectionError
      self.class.set(wait: 5.minutes).perform_later(search_term)
    end
  end

  class TwitterClient
    attr_reader :client

    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = Rails.application.credentials.twitter[:consumer_api_key]
        config.consumer_secret     = Rails.application.credentials.twitter[:consumer_secret_key]
        config.access_token        = Rails.application.credentials.twitter[:access_token]
        config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
      end
    end
  end
end
