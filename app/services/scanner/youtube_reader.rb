module Scanner
  class YoutubeReader < Reader
    
    # -------------------------------------------------------------------
    def process(publisher, entry)
      
      # If the RSS entry contains a publish date, a title and a link
      if entry[:title] && entry[:link]
        now = Time.new
        
        article = Article.new(
          {target: entry[:link].gsub('watch?v=', 'embed/'), 
           title: strip_html(entry[:title]), 
           author: strip_html(entry[:author]), 
           publication_date: (entry[:published].nil? ? Time.now : Date.parse(strip_html(entry[:published]))), 
           thumbnail: get_video_thumbnail(entry[:link].gsub('watch?v=', 'embed/')),
           media: nil,
           media_type: 'video',
           media_host: 'youtube.com',
           content: '',
           publisher: publisher})
      end
    end
    
  end
end  

# Example of response from Youtube RSS feed using the Nokogiri XML parser
# --------------------------------------------------------------------------
=begin
<feed xmlns:yt="http://www.youtube.com/xml/schemas/2015" xmlns:media="http://search.yahoo.com/mrss/" xmlns="http://www.w3.org/2005/Atom">
 <link rel="self" href="http://www.youtube.com/feeds/videos.xml?channel_id=UCAob5GmjrCYCHNk3S8O9yXQ"/>
 <id>yt:channel:UCAob5GmjrCYCHNk3S8O9yXQ</id>
 <yt:channelId>UCAob5GmjrCYCHNk3S8O9yXQ</yt:channelId>
 <title>SailingBritican</title>
 <link rel="alternate" href="http://www.youtube.com/channel/UCAob5GmjrCYCHNk3S8O9yXQ"/>
 <author>
  <name>SailingBritican</name>
  <uri>http://www.youtube.com/channel/UCAob5GmjrCYCHNk3S8O9yXQ</uri>
 </author>
 <published>2014-02-11T20:52:06+00:00</published>
 <entry>
  <id>yt:video:njGS8zEUBks</id>
  <yt:videoId>njGS8zEUBks</yt:videoId>
  <yt:channelId>UCAob5GmjrCYCHNk3S8O9yXQ</yt:channelId>
  <title>Charleston - Sightseeing and Sailing</title>
  <link rel="alternate" href="http://www.youtube.com/watch?v=njGS8zEUBks"/>
  <author>
   <name>SailingBritican</name>
   <uri>http://www.youtube.com/channel/UCAob5GmjrCYCHNk3S8O9yXQ</uri>
  </author>
  <published>2016-12-01T16:27:03+00:00</published>
  <updated>2016-12-06T18:48:44+00:00</updated>
  <media:group>
   <media:title>Charleston - Sightseeing and Sailing</media:title>
   <media:content url="https://www.youtube.com/v/njGS8zEUBks?version=3" type="application/x-shockwave-flash" width="640" height="390"/>
   <media:thumbnail url="https://i3.ytimg.com/vi/njGS8zEUBks/hqdefault.jpg" width="480" height="360"/>
   <media:description>Remember to get your FREE GUIDE: How to make money while sailing around the world: https://sailingbritican.com/make-money-sailing-free-guide/

Sightseeing and Sailing in Charleston

Charleston, South Carolina is one of the best cities to visit in the United States. If you are sailing along the east coast it would be a terrible shame to bypass this amazing area. Sailing and sightseeing in Charleston is awesome.

Visit https://sailingbritican.com for over 300 articles about sailing tips, how-to's, living aboard articles, recipes and more....

Find Sailing Britican at the following locations:
- Facebook: https://www.facebook.com/SailingBritican/?ref=hl 
- Google+: https://plus.google.com/u/0/b/105774700156303364122/+Sailingbritican/posts
- LinkedIn: https://www.linkedin.com/profile/view?id=82549277&amp;trk=nav_responsive_tab_profile
- Pinterest: https://www.pinterest.com/kbrown0149/
- Twitter: https://twitter.com/sailingbritican
- Ello: @kimharkolabrown

Music by Kevin MacLeod (incompetech.com)
Licensed under Creative Commons: By Attribution 3.0 License
http://creativecommons.org/licenses/by/3.0/</media:description>
   <media:community>
    <media:starRating count="92" average="4.91" min="1" max="5"/>
    <media:statistics views="1174"/>
   </media:community>
  </media:group>
 </entry>
=end