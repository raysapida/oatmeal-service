class TwitterController < ApplicationController
  def index
    # TODO: Create model for saving Tweets in the database
    # @tweets = Tweet.all
    @tweets = []

    render json: { tweets: @tweets }
  end

  def search
    twitter = TwitterClient.new
    @tweets = twitter.client.search(params[:q], result_type: "recent").take(10)
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
