module Scanner
  class RssReader < Reader
    
    # -------------------------------------------------------------------
    def process(entry)
      
      content = (entry.content_encoded.nil? ? entry.description : entry.content_encoded)      
      date = entry.pubDate
      author = (entry.author.nil? ? entry.dc_creator.to_s : entry.author)
      categories, unknowns = [], []

      # If the RSS entry contains content, a publish date, a title and a link
      if content && date && entry.title && entry.link
        if entry.category.nil?
          category = detect_category(entry.dc_subject.to_s) unless entry.dc_subject.nil?
        else
          category = detect_category(entry.category.to_s)
        end
    
        categories << category if category.is_a?(Category)
        unknowns << category if category.is_a?(UnknownTag)
        
        hash = detect_media_content(entry.description)
      
        article = Article.new(
          {target: entry.link, 
           title: entry.title, 
           author: (author ? clean_author(author) : nil), 
           publication_date: (date ? date : nil), 
           thumbnail: hash[:thumb],
           media: hash[:media],
           media_type: hash[:type],
           media_host: hash[:host],
           content: clean_html(strip_html(content)),
           categories: categories,
           unknown_tags: unknowns})
      end # no content, date, title and/or link
    end
    
  end
end  