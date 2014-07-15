class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :query_id
      t.string :message
      t.string :direction
      t.datetime :tweet_date

      t.timestamps
    end
  end
end
