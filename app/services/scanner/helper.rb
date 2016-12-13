module Scanner
  module Helper
  
    # -------------------------------------------------------------------   
    def detect_media_content(content)
      type, host, thumb, media = nil, nil, nil, nil

      img_matches = content.match(/<img.+?src=[\'"](.+?)[\'"].*?>/)
      aud_matches = content.match(/<audio.+?src=[\'"](.+?)[\'"].*?>/)
      vid_matches = content.match(/<video.+?src=[\'"](.+?)[\'"].*?>/)
      fra_matches = content.match(/<iframe.+?src=[\'"](.+?)[\'"].*?>/)

      source = Proc.new{ |text| text.match(/src=[\'"](.+?)[\'"]/)[0].
                                 gsub(/src=[\'"]/, "").gsub('"', '') }

      if aud_matches
        type = 'audio'
        media = source.call(aud_matches[0])
        host = (media ? URI.parse(media).hostname : null)
        host = (host ? host.gsub('www.', '') : null)
        thumb = source.call(img_matches[0])

      elsif vid_matches
        type = 'video'
        media = source.call(vid_matches[0])
        host = (media ? URI.parse(media).hostname : null)
        host = (host ? host.gsub('www.', '') : null)
        thumb = source.call(img_matches[0])

      elsif fra_matches
        media = source.call(fra_matches[0])
        media = (media.starts_with?('//') ? 'http:' + media : media)

        if media.include?('html5-player.libsyn')
          media = media.gsub('/autoplay/yes/', '/autoplay/no/')
                       .gsub('/thumbnail/no/', '/thumbnail/yes/')
        end

        host = (media ? URI.parse(media).hostname : null)
        host = (host ? host.gsub('www.', '') : null)
    
        if img_matches
          thumb = source.call(img_matches[0])
        end

        # If the content is not from an approved host Null it out
        if Rails.configuration.jobs[:scanner][:articles][:valid_video_hosts].include?(host)
          type = 'video'
        elsif Rails.configuration.jobs[:scanner][:articles][:valid_audio_hosts].include?(host)
          type = 'audio'
        else
          type, media, host = nil, nil, nil
        end
    
      elsif img_matches
        thumb = source.call(img_matches[0]);
      end

      {type: type, host: host, thumb: thumb, media: media}
    end
  
    # -------------------------------------------------------------------   
    def detect_category(tag)
      tag = strip_html(tag)
      category = Category.find_by(slug: tag.downcase.gsub(' ', '-'))
    
      if category.nil?
        category = UnknownTag.new(value: tag)
      end
    
      category
    end
  
    # -------------------------------------------------------------------   
    def escaped_to_html(content)
      content.gsub(/&quot;/, '"').
              gsub(/&lt;/, '<').
              gsub(/&gt;/, '>').
              gsub(/&amp;/, '&')
    end
  
    # -------------------------------------------------------------------
    def word_count(content)
      content.split(' ').count
    end
  
    # -------------------------------------------------------------------
    def clean_html(content)
      content.gsub(/\s\s+/, ' ').
              gsub(/\\t/, '').
              gsub(/\\n/, '').
              gsub(/\\t/, '').
              gsub(/&#160;/, '').
              gsub(/&#39;/, "'").
              gsub(/&[lr]dquo;/, '"').
              gsub(/&[lr]squo;/, "'").
              gsub(/\[&#8230;\]/, '').
              gsub(/&#8230;/, '...').
              gsub(/&#8211;/, "-").
              gsub(/&#821[67];/, "'").
              gsub(/\\xe2\\x80\\x9[89]/, "'").
              gsub(/\\xe2\\x80\\x9[cd]/, '"').
              gsub(/\\xe2\\x80\\x93/, "-").
              gsub(/\\xe2\\x80\\x94/, "--").
              gsub(/\\xe2\\x80\\xa6/, "...")
    end
  
    # -------------------------------------------------------------------
    def strip_html(content)
      content.gsub(/<[^>]*>/, '')
    end
  
    # -------------------------------------------------------------------   
    def clean_author(author)
      auth = author.gsub(/@.*\.[a-z]+/, '')
      parts = auth.split('.')

      (parts[0].capitalize + (parts[1] ? (' ' + parts[1].capitalize) : ''))
    end
  
  end
end