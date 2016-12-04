module Scanner
  class RssReader < Reader
    
    # -------------------------------------------------------------------
    def process(entry)
      content = (entry['content:encoded'] ? entry['content:encoded'] : 
      																(entry.content ? entry.content : entry.description))
      date = (entry.date ? entry.date : entry['dc:date'])
      author = (entry.author ? entry.author : entry['dc:creator']),
      categories = []

      # If the RSS entry contains content, a publish date, a title and a link
      if content && date && entry.title && entry.link
      	if entry.categories
      		if entry.categories[0].is_a?(String)
      			categories = entry.categeories;
          else
      			if entry.categories[0]['_']
      				categories = entry.categories.map{ |c| c['_'] }
            end
          end
          
        elsif entry.category
      		categories = entry.category
        end
    
    		hash = detect_media_content(entry.description)
        
        article = Article.new(
    			{id: entry.link, 
    			 title: entry.title, 
				 	 author: (author ? clean_author(author) : nil), 
					 publication_date: (date ? Date.parse(date) : nil), 
					 thumbnail: hash[:thumb],
					 media: hash[:media],
					 media_type: hash[:type],
					 media_host: hash[:host],
					 content: clean_html(strip_html(content)),
					 categories: categories})
        
      end # no content, date, title and/or link
    end
    
    
    protected 
      # -------------------------------------------------------------------
      def set_headers(req)
        req['Accept'] = 'application/rss+xml'
        super
      end
    
  end
end  