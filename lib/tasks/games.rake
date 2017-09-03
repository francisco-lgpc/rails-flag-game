namespace :games do
  desc "Deletes unfinished games, that are over 1 day old."
  task clean: :environment do
    puts "Cleaning database..."
    CleanUpGamesJob.perform_later
  end
end
