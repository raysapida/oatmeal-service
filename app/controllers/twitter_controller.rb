class TwitterController < ApplicationController
  def index
    search_term = params[:q]
    @tweets = Tweet.where(search_term: search_term).order(created_at: :desc).limit(10)
    render json: { tweets: @tweets }
  end

  def search
    twitter = TwitterClient.new
    search_term = params[:q]
    tweets = twitter.client.search("##{search_term}", result_type: "recent").take(10)
    @tweets = []
    tweets.each do |tweet|
      @tweets << Tweet.create(full_text: tweet.full_text, screen_name: tweet.user.screen_name, created_at: tweet.created_at, search_term: search_term)
    end
    TweetsUpdateJob.perform_later(search_term)
    render json: { status: 'ok' , tweets: @tweets }
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
