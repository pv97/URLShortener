namespace :myrailsapp do
  task purge_urls: :environment do
      puts "Purging old audits..."
      ShortenedUrl.where("created_at < ?", 1.minute.ago).delete_all# { |url| url.created_at < 0.minutes.ago }
    end
end
