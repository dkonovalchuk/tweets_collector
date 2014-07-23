class Tweet < ActiveRecord::Base
  belongs_to :query

  DIRECTION = { outgoing: "outgoing", incoming: "incoming" }
  UNNEEDED = "RT "

  scope :since, ->(time) { where("tweet_date >= ?", time) }
  scope :hourly, -> { since(Time.now - 1.hour) }
  scope :daily, -> { since(Time.now - 24.hours) }
  scope :newest_first, -> { order(tweet_date: :desc) }

  class << self

    def create_uniq(tweet, direction)
      return unless uniq?(tweet)
      create(message: tweet.text, tweet_date: tweet.created_at, direction: DIRECTION[direction])
    end

    def uniq?(tweet)
      where(message: tweet.text, tweet_date: tweet.created_at).count.zero?
    end
  end

  def to_s
    message.gsub(UNNEEDED, "").gsub(username_link, "")
  end

  def username_link
    "@#{query.username} "
  end
end
