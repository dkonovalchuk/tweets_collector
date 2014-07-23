class TweetsController < ApplicationController

  def index
    @query = Query.find(query_id)
    @tweets = tweets_for_query

    respond_to do |format|
      format.html
      format.text
      format.json do
        render json: @tweets.map { |t| t.slice(:id, :message) }
      end
    end
  end

  private

  def query_id
    params.permit(:query_id).fetch(:query_id)
  end

  def tweets_for_query
    period = params.permit(:period).fetch(:period) { :hourly }
    @query.tweets.public_send(period).newest_first
  end
end
