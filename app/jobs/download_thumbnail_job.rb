class DownloadThumbnailJob < ApplicationJob
  queue_as :default
  
  def perform(article_id)
    downloader = DownloaderService.new
    
    begin
      article = Article.find(article_id)
      
      uri = URI.parse(article.thumbnail)
    
      location = downloader.download(uri)
    
puts "LOCATION: #{location}"
    
      unless location.nil?
        article.thumbnail = location
        article.save!
      end
    
    rescue Exception => e
      puts e
    end
    
    #after_enqueue
    
    #after_preform
    
  end
  
end