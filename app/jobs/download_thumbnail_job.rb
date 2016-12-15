class DownloadThumbnailJob < ApplicationJob
  queue_as :default
  
  Rails.logger = Logger.new("#{Rails.root}/log/download_thumbnail.log")
  
  def perform(article_id)
    downloader = ThumbnailService.new
    
    begin
      article = Article.find(article_id)
    
      # Retrieve a thumbnail for the video content
      if article.media_type == 'video'
        article = downloader.retrieve_thumbnail_for_video(article)
        
      elsif !article.thumbnail.nil?
        uri = URI.parse(article.thumbnail)
        
        article.thumbnail = downloader.download(uri)
      end
    
      article.save!
      
    rescue Exception => e
      Rails.logger.error "DownloadThumbnailJob.perform - Unable to download thumbnail for #{article.target} : #{e}"
    end
    
    #after_enqueue
    
    #after_preform
    
  end
  
end