module Scanner
  module Helper
  
    # -------------------------------------------------------------------   
    def detect_media_content(content)
      type, host, thumb, media = nil, nil, nil, nil

      img_matches = content.match(/<img.+?src=[\'"](.+?)\.(jpg|jpeg|png|gif)(.+?)[\'"].*?>/)
      aud_matches = content.match(/<audio.+?src=[\'"](.+?)[\'"].*?>/)
      vid_matches = content.match(/<video.+?src=[\'"](.+?)[\'"].*?>/)
      fra_matches = content.match(/<iframe.+?\s+src=[\'"](.+?)[\'"].*?>/)
      fra_thmb_matches = content.match(/<iframe.+?data-thumbnail-src=[\'"](.+?)[\'"].*?>/)

      source = Proc.new{ |text| text.match(/src=[\'"](.+?)[\'"]/)[0].
                                 gsub(/src=[\'"]/, "").gsub('"', '') }

      if aud_matches
        type = 'audio'
        media = source.call(aud_matches[0])
        host = (media ? URI.parse(media).hostname : nil)
        host = (host ? host.gsub('www.', '') : nil)
        thumb = source.call(img_matches[0])

      elsif vid_matches
        type = 'video'
        media = source.call(vid_matches[0])
        host = (media ? URI.parse(media).hostname : nil)
        host = (host ? host.gsub('www.', '') : nil)
        thumb = source.call(img_matches[0])

      elsif fra_thmb_matches
        thumb = source.call(fra_thmb_matches[0]);
        
      elsif fra_matches
        media = source.call(fra_matches[0])
        media = (media.starts_with?('//') ? 'http:' + media : media)

        if media.include?('html5-player.libsyn')
          media = media.gsub('/autoplay/yes/', '/autoplay/no/')
                       .gsub('/thumbnail/no/', '/thumbnail/yes/')
        end
        
        # trim off any player settings, we don't need them and they can cause URI parsing issues
        media = media.slice(0..media.index('?')) unless media.index('?').nil?

        host = (media ? URI.parse(media).hostname : nil)
        host = (host ? host.gsub('www.', '') : nil)
    
        if img_matches
          thumb = source.call(img_matches[0])
        end

        # If the content is not from an approved host Null it out
        if Rails.configuration.jobs[:scanner][:articles][:valid_video_hosts].include?(host)
          type = 'video'
        elsif Rails.configuration.jobs[:scanner][:articles][:valid_audio_hosts].include?(host)
          type = 'audio'
        else
          puts "Scanner::Helper.detect_media_content #{media} - : Unknown media host, #{host}"
          type, media, host = nil, nil, nil
        end
    
      elsif img_matches
        thumb = source.call(img_matches[0])
      end
      
      {type: type, host: host, thumb: (thumb.nil? ? thumb : thumb.gsub("'", "")), media: media}
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
              gsub(/\\xe2\\x80\\xa6/, "...").
              gsub(/&#822[01];/, '"').
              gsub(/&nbsp;/, ' ').
              gsub(/\\x[A-F0-9]{2}/, '').
              gsub(/&#[0-9]+;/, '')
    end
  
    # -------------------------------------------------------------------
    def strip_html(content)
      content.gsub(/<[^>]*>/, '')
    end
  
    # -------------------------------------------------------------------
    def clean_author(author)
      auth = author.gsub(/@.*\.[a-z]+/, '')
      parts = auth.split('.')

      if parts.empty?
        author
      else
        (parts[0].capitalize + (parts[1] ? (' ' + parts[1].capitalize) : ''))
      end
    end
  
    # -------------------------------------------------------------------
    def get_uris(string)
      regex = /https?:\/\/[-a-zA-Z0-9@:%_\+.~#?&\/=]{2,256}\.[a-z]{2,4}\/[-a-zA-Z0-9@:%_\+.~#?&\/=]*/
      string.scan(regex)
    end
  
  end
end