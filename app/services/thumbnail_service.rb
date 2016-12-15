require 'mini_magick'
require 'aws-sdk'

class ThumbnailService
  
  # -----------------------------------------------------------------------
  def initialize
    Aws.config.update({
      region: Rails.configuration.jobs[:thumbnail][:storage][:region],
      credentials: Aws::Credentials.new(Rails.configuration.jobs[:thumbnail][:storage][:access_key],
                                        Rails.configuration.jobs[:thumbnail][:storage][:access_secret])
    })
    
    s3 = Aws::S3::Resource.new
    @bucket = s3.bucket(Rails.configuration.jobs[:thumbnail][:storage][:bucket])
    
    @target = Rails.configuration.jobs[:thumbnail][:storage][:host]
  end
  
  # -----------------------------------------------------------------------
  def download(uri)
    id = "#{SecureRandom.uuid}.jpg"
    
    if @bucket
      # Download and resize the image
      image = MiniMagick::Image.open(uri.to_s)
      image.resize(850).write("#{@tmp_path}#{id}")
      
      # Transfer the image to S3
      begin
        object = @bucket.object("#{id}")
        
        File.open("#{@tmp_path}#{id}", 'rb') do |file|
          object.put(body: file)
        end
        
        File.delete("#{@tmp_path}#{id}")
        
        "#{@target}#{id}"
        
      rescue Exception => e
        Rails.logger.error "ThumbnailService.download - Unable to save thumbnail image to S3 : #{e}"
        
        "#{uri}"
      end
    end
    
  end
  
  # -----------------------------------------------------------------------
  def delete(uri)
    # If we're hosting the thumbnail
    if uri.starts_with?(Rails.configuration.jobs[:thumbnail][:storage][:host])
    
      id = uri.match(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\.jpg/)
    
      if id && @bucket && 
        begin
          @bucket.object("#{id[0]}").delete
        
        rescue Exception => e
          Rails.logger.error "ThumbnailService.delete - Unable to delete #{uri} : #{e}"
          false
        end
      end
    end
  end
  
  # ---------------------------------------------------------------------------
  def retrieve_thumbnail_for_video(article)
    uri = URI.parse(article.target)
  
    if article.media_host.include?('youtu')
      # Generate the URL of the Youtube thumbnail
      vid_id = uri.path.gsub('/embed/', '').gsub(/\?.*/, '')
  
      article.thumbnail = "http://i.ytimg.com/vi/#{vid_id}/hqdefault.jpg"
      article.media = "#{article.target}?autoplay=1&rel=0"
  
    elsif article.media_host.include?('vimeo')
      # Call the vimeo API to get the location of the thumbnail
      target = URI.parse("https://vimeo.com/api/oembed.json?url=#{article.target}")

      opts = {url: target, }
    
      request = Net::HTTP::Get.new(target)
      request['Accept'] = 'application/json'
      request['User-Agent'] = 'request'

      response = Net::HTTP.start(target.hostname, target.port, 
                                  use_ssl: target.scheme == 'https') do |http|
        http.request(request)
      end

      json = JSON.parse(response.body)

      article.thumbnail = (json['thumbnail_url'] ? json['thumbnail_url'] : nil)        
    end
  
    unless article.thumbnail.nil?
      article.thumbnail = download(article.thumbnail)
    end
    
    article
  end
  
end
