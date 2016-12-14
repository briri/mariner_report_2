class DownloadThumbnailJob < ApplicationJob
  queue_as :default
  
  def perform(article_id)
    downloader = ThumbnailService.new
    
    begin
      article = Article.find(article_id)
      
      uri = URI.parse(article.thumbnail)
    
      # Retrieve a thumbnail for the video content
      if article.media_type == 'video'
        article = downloader.retrieve_thumbnail_for_video(article)
        
      elsif !article.thumbnail.nil?
        article.thumbnail = downloader.download(uri)
      end
    
      article.save!
      
    rescue Exception => e
      puts "DownloadThumbnailJob.perform - Unable to download thumbnail for #{article.target} : #{e}"
    end
    
    #after_enqueue
    
    #after_preform
    
  end
  
end