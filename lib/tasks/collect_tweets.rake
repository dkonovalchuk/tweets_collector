desc "Collect and save tweets"
task collect_tweets: :environment do
  puts "Collecting..."
  Query.all.each { |q| TweetCollector.new(q).collect_tweets }
  puts "Done!"
end