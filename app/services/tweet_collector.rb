class TweetCollector

  def initialize(query)
    @query = query
  end

  MAX_OUTGOING_TWEETS_COUNT = 200
  MAX_INCOMING_TWEETS_COUNT = 100

  def collect_tweets
    save_outgoing_tweets
    save_incoming_tweets
  end

  private

  def save_outgoing_tweets
    tweets = client.user_timeline(@query.username, outgoing_tweets_options)
    save_uniq_from(tweets, :outgoing)
  end

  def save_incoming_tweets
    tweets = client.search("to:#{@query.username}", incoming_tweets_options)
    save_uniq_from(tweets, :incoming)
  end

  def save_uniq_from(tweets, direction)
    Tweet.transaction do
      tweets.each { |tweet| @query.tweets.create_uniq(tweet, direction) }
    end
  end

  def outgoing_tweets_options
    { count: MAX_OUTGOING_TWEETS_COUNT }
  end

  def incoming_tweets_options
    { result_type: "mixed", count: MAX_INCOMING_TWEETS_COUNT }
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = api_config[:consumer_key]
      config.consumer_secret     = api_config[:consumer_secret]
      config.access_token        = api_config[:access_token]
      config.access_token_secret = api_config[:access_token_secret]
    end
  end

  def api_config
    @api_config ||= YAML::load_file(File.join(Rails.root, "config", "api_config.yml"))[Rails.env].symbolize_keys
  end
end