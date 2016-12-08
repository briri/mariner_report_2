require 'mini_magick'
require 'aws-sdk'

class DownloaderService
  
  # -----------------------------------------------------------------------
  def initialize
#    @tmp_path = Rails.configuration.jobs[:downloader][:temporary_storage][:path]
#    @tmp_path = (@tmp_path.starts_with?('.') ? "#{Rails.root.to_s}#{@tmp_path.slice(1, @tmp_path.count)}" :
#                              @tmp_path.starts_with('/') ? "#{Rails.root.to_s}#{@tmp_path}" : @tmp_path)

#    @tmp_path = "#{@tmp_path}/" unless @tmp_path.ends_with?('/')
    
    Aws.config.update({
      region: Rails.configuration.jobs[:downloader][:storage][:region],
      credentials: Aws::Credentials.new(Rails.configuration.jobs[:downloader][:storage][:access_key],
                                        Rails.configuration.jobs[:downloader][:storage][:access_secret])
    })
    
    s3 = Aws::S3::Resource.new
    @bucket = s3.bucket(Rails.configuration.jobs[:downloader][:storage][:bucket])
    @key = Rails.configuration.jobs[:downloader][:storage][:key]
    
    @target = Rails.configuration.jobs[:downloader][:storage][:host]
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
        object = @bucket.object(id)
        
        File.open("#{@tmp_path}#{id}", 'rb') do |file|
          object.put(body: file)
        end
        
        File.delete("#{@tmp_path}#{id}")
        
      rescue Exception => e
        puts e
      end
      
      "#{@target}#{id}"
    end
    
  end
  
end
